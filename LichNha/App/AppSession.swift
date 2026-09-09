import Foundation
import SwiftData
import CalendarCore
import ContentCore
import AlmanacCore
import PersonalCore
import ReminderCore
import EffectCore
import Observation
import WidgetKit

enum CalendarSurface: String, Sendable {
    case todayFront
    case dayBack
    case month
    case events
    case eventEditor
    case paperDrawer
}

@MainActor
@Observable
final class AppSession {
    var selectedDate: CivilDate
    var surface: CalendarSurface = .todayFront
    var monthYear: Int
    var monthMonth: Int
    var canReturnToMonth = false
    var presentedSourceID: String?
    var catalog: ContentCatalog?
    var catalogNotice: String?
    var effectCatalog: EffectCatalog?
    var almanacVisible: Bool
    var preferences: UserPreferences
    var pendingReplay = false
    var settingsReturnSurface: CalendarSurface = .todayFront
    var personalEvents: [PersonalEvent] = []
    var eventDraft: PersonalEvent?
    var editingIsNew = true
    var lastSaveSucceeded = false
    var lastSavedStatus: ReminderEventStatus?
    var notificationPermission: NotificationAuthorization
    let personalRepository: PersonalEventRepository
    let reminderCoordinator: ReminderRefreshCoordinator
    let preferenceStore: UserPreferencesStore
    let timeContext: TimeContext
    let calendarModel: TodayViewModel

    init(
        timeContext: TimeContext = TimeContext(displayZone: .vietnam, deliveryZone: .vietnam),
        repository: PersonalEventRepository? = nil,
        scheduler: (any NotificationScheduling)? = nil,
        preferenceStore: UserPreferencesStore = .makeShared()
    ) {
        self.preferenceStore = preferenceStore
        if LaunchConfiguration.resetPersonalStore {
            preferenceStore.reset()
        }
        let loaded = preferenceStore.load()
        self.preferences = loaded
        var context = timeContext
        context.deliveryZone = loaded.deliveryZone
        self.timeContext = context
        let start = Self.launchDate() ?? context.today(in: context.displayZone)
        self.selectedDate = start
        self.monthYear = start.year
        self.monthMonth = start.month
        self.almanacVisible = loaded.almanacVisible
        let model = TodayViewModel(timeContext: context)
        model.selectedDate = start
        model.refresh()
        self.calendarModel = model

        if let repository {
            self.personalRepository = repository
        } else {
            let container = Self.makeStore()
            self.personalRepository = PersonalEventRepository(container: container)
        }
        if LaunchConfiguration.resetPersonalStore {
            try? personalRepository.deleteAll()
        }
        let permission: NotificationAuthorization = LaunchConfiguration.denyNotifications ? .denied : .notRequested
        self.notificationPermission = permission
        let store = scheduler ?? Self.makeScheduler(permission: permission)
        self.reminderCoordinator = ReminderRefreshCoordinator(
            repository: personalRepository,
            scheduler: store,
            permission: permission
        )
        reloadPersonalEvents()
    }

    private static func makeStore() -> ModelContainer {
        let reset = LaunchConfiguration.resetPersonalStore
        #if targetEnvironment(simulator)
        if let container = try? PersonalSchema.makeApplicationSupportContainer(reset: reset) {
            return container
        }
        #else
        if let container = try? PersonalSchema.makeContainer() {
            if reset {
                try? PersonalEventRepository(container: container).deleteAll()
            }
            return container
        }
        if let container = try? PersonalSchema.makeApplicationSupportContainer(reset: reset) {
            return container
        }
        #endif
        return try! PersonalSchema.makeInMemoryContainer()
    }

    private static func makeScheduler(permission: NotificationAuthorization) -> any NotificationScheduling {
        if LaunchConfiguration.isUITesting {
            return InMemoryNotificationScheduler(authorization: permission)
        }
        return SystemNotificationScheduler()
    }

    var day: CalendarDay? { calendarModel.day }

    func syncFromCalendarModel() {
        selectedDate = calendarModel.selectedDate
        monthYear = selectedDate.year
        monthMonth = selectedDate.month
    }

    func selectDate(_ civil: CivilDate) {
        guard civil.isInPublishedRange else { return }
        selectedDate = civil
        calendarModel.selectedDate = civil
        calendarModel.refresh()
        surface = .todayFront
    }

    func openMonth() {
        monthYear = selectedDate.year
        monthMonth = selectedDate.month
        canReturnToMonth = true
        surface = .month
    }

    func closeMonthWithoutChangingDate() {
        surface = .todayFront
    }

    func openDayBack() {
        surface = .dayBack
    }

    func closeDayBack() {
        surface = .todayFront
    }

    func returnToMonth() {
        monthYear = selectedDate.year
        monthMonth = selectedDate.month
        surface = .month
    }

    func openSource(_ id: String) {
        presentedSourceID = id
    }

    func shiftMonth(by delta: Int) {
        var month = monthMonth + delta
        var year = monthYear
        while month < 1 {
            month += 12
            year -= 1
        }
        while month > 12 {
            month -= 12
            year += 1
        }
        let probe = CivilDate(year: year, month: month, day: 1)
        guard probe.isInPublishedRange else { return }
        monthYear = year
        monthMonth = month
    }

    func applyDeepLink(civil: CivilDate) {
        selectDate(civil)
        canReturnToMonth = false
    }

    func applyLaunchSurface() {
        switch LaunchConfiguration.launchSurface {
        case .month:
            openMonth()
        case .dayBack:
            openDayBack()
        case .events:
            openEvents()
        case .eventEditor:
            openNewEventEditor()
        case .paperDrawer:
            openSettings()
        case .todayFront, .none:
            break
        }
    }

    func updatePreferences(_ body: (inout UserPreferences) -> Void) {
        body(&preferences)
        preferenceStore.save(preferences)
        almanacVisible = preferences.almanacVisible
        AlmanacVisibilitySetting.isEnabled = preferences.almanacVisible
    }

    func setAlmanacVisible(_ enabled: Bool) {
        updatePreferences { $0.almanacVisible = enabled }
    }

    func openSettings() {
        if surface != .paperDrawer {
            settingsReturnSurface = surface
        }
        surface = .paperDrawer
    }

    func closeSettings() {
        surface = settingsReturnSurface == .paperDrawer ? .todayFront : settingsReturnSurface
    }

    var audioSettings: AudioLayerSettings {
        let bed: AmbientBed
        switch preferences.ambient {
        case .yen: bed = .yen
        case .hienSom: bed = .hienSom
        case .muaXa: bed = .muaXa
        case .quatTrua: bed = .quatTrua
        }
        return AudioLayerSettings(
            ambient: bed,
            paperCuesEnabled: preferences.paperCuesEnabled,
            eventCuesEnabled: preferences.eventCuesEnabled
        )
    }

    func openEvents() {
        reloadPersonalEvents()
        surface = .events
    }

    func closeEvents() {
        surface = .todayFront
    }

    func openNewEventEditor() {
        let lunar = calendarModel.day?.lunarDate ?? LunarDate(
            day: 12,
            month: 8,
            year: selectedDate.year,
            isLeapMonth: false,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        )
        eventDraft = PersonalEvent(
            id: UUID().uuidString,
            title: "",
            calendarBasis: .lunar,
            originCivilDate: selectedDate,
            originLunarDate: lunar,
            recurrence: .yearly,
            leapMonthPolicy: lunar.isLeapMonth ? .leapMonth : .regularMonth,
            reminderPolicy: ReminderPolicy(enabled: true, leadDays: 3, hour: 8, minute: 0),
            deliveryZone: preferences.deliveryZone,
            widgetPrivacy: preferences.widgetPrivacy
        )
        editingIsNew = true
        lastSaveSucceeded = false
        lastSavedStatus = nil
        surface = .eventEditor
    }

    func openEventEditor(_ event: PersonalEvent) {
        eventDraft = event
        editingIsNew = false
        lastSaveSucceeded = true
        lastSavedStatus = reminderCoordinator.lastPlans[event.id]?.eventStatus
        surface = .eventEditor
    }

    func closeEventEditor() {
        eventDraft = nil
        lastSaveSucceeded = false
        reloadPersonalEvents()
        surface = .events
    }

    func reloadPersonalEvents() {
        personalEvents = (try? personalRepository.allEvents()) ?? []
    }

    func mutateDraft(_ body: (inout PersonalEvent) -> Void) {
        guard var draft = eventDraft else { return }
        body(&draft)
        eventDraft = draft
    }

    func updateLunarDay(_ day: Int) {
        mutateDraft { draft in
            var lunar = draft.originLunarDate ?? LunarDate(
                day: 1, month: 1, year: selectedDate.year, isLeapMonth: false,
                ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
            )
            lunar.day = min(30, max(1, day))
            draft.originLunarDate = lunar
        }
    }

    func updateLunarMonth(_ month: Int) {
        mutateDraft { draft in
            var lunar = draft.originLunarDate ?? LunarDate(
                day: 12, month: 1, year: selectedDate.year, isLeapMonth: false,
                ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
            )
            lunar.month = min(12, max(1, month))
            draft.originLunarDate = lunar
        }
    }

    func updateLunarLeap(_ isLeap: Bool) {
        mutateDraft { draft in
            var lunar = draft.originLunarDate ?? LunarDate(
                day: 12, month: 8, year: selectedDate.year, isLeapMonth: false,
                ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
            )
            lunar.isLeapMonth = isLeap
            draft.originLunarDate = lunar
            if isLeap { draft.leapMonthPolicy = .leapMonth }
        }
    }

    func updateSolarDay(_ day: Int) {
        mutateDraft { draft in
            var civil = draft.originCivilDate ?? selectedDate
            civil.day = min(31, max(1, day))
            draft.originCivilDate = civil
        }
    }

    func updateSolarMonth(_ month: Int) {
        mutateDraft { draft in
            var civil = draft.originCivilDate ?? selectedDate
            civil.month = min(12, max(1, month))
            draft.originCivilDate = civil
        }
    }

    func personalEvents(on civil: CivilDate) -> [PersonalEvent] {
        personalEvents.filter { event in
            !ReminderPlanner.targetCivilDates(event: event, windowStart: civil, windowEnd: civil).isEmpty
        }
    }

    func saveDraft() async {
        guard var draft = eventDraft else { return }
        let trimmed = draft.title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        draft.title = trimmed
        draft.updatedAt = Date()
        if draft.createdAt.timeIntervalSince1970 == 0 {
            draft.createdAt = draft.updatedAt
        }
        eventDraft = draft
        do {
            try personalRepository.upsert(draft)
            if draft.reminderPolicy.enabled, !LaunchConfiguration.denyNotifications {
                notificationPermission = await reminderCoordinator.requestPermission()
            }
            try await reminderCoordinator.refresh(reason: .appActive)
            reloadPersonalEvents()
            lastSaveSucceeded = true
            lastSavedStatus = reminderCoordinator.lastPlans[draft.id]?.eventStatus
                ?? (notificationPermission == .denied ? .permissionDenied : .saved)
            if notificationPermission == .denied {
                lastSavedStatus = .permissionDenied
            }
            publishWidgetSnapshots()
        } catch {
            lastSaveSucceeded = false
            lastSavedStatus = .planningError
        }
    }

    func loadCatalog(bundle: Bundle = .main, cache: URL) {
        do {
            catalog = try ContentCatalog.loadFromBundle(bundle, cacheDirectory: cache)
            catalogNotice = catalog?.usedFallback == true ? "Đang dùng bản nội dung đã kiểm hợp lệ gần nhất." : nil
        } catch {
            do {
                catalog = try ContentCatalog.load(from: cache, cacheDirectory: cache)
                catalogNotice = "Đang dùng bản nội dung đã kiểm hợp lệ gần nhất."
            } catch {
                catalog = nil
                catalogNotice = "Không đọc được gói nội dung; vẫn hiện ngày dương và âm."
            }
        }
        publishWidgetSnapshots()
    }

    func loadEffects(bundle: Bundle = .main, cache: URL) {
        do {
            effectCatalog = try EffectCatalog.loadFromBundle(bundle, cacheDirectory: cache)
        } catch {
            do {
                effectCatalog = try EffectCatalog.load(from: cache, cacheDirectory: cache)
            } catch {
                effectCatalog = nil
            }
        }
    }

    func publishWidgetSnapshots(now: Date = Date()) {
        let zone = timeContext.displayZone
        let dates = WidgetTimelinePlanning.timelineDates(from: now, zone: zone, dayCount: 3)
        var snapshots: [WidgetSnapshot] = []
        for civil in dates where civil.isInPublishedRange {
            guard let day = try? VietnameseLunarCalendar.calendarDay(
                civil: civil,
                displayTimeZone: zone,
                timeContext: timeContext
            ) else { continue }
            let publicTitles = catalog?.occurrences(on: day).map(\.title) ?? []
            let personal = personalEvents(on: civil).map {
                WidgetPersonalInput(title: $0.title, notes: $0.notes, privacyRaw: $0.widgetPrivacy.rawValue)
            }
            snapshots.append(
                WidgetSnapshotBuilder.build(
                    day: day,
                    publicTitles: publicTitles,
                    personal: personal,
                    now: now,
                    displayZone: zone
                )
            )
        }
        try? WidgetSnapshotStore.saveToSharedContainer(
            WidgetSnapshotFile(displayZone: zone.rawValue, snapshots: snapshots)
        )
        WidgetCenter.shared.reloadTimelines(ofKind: "LichNhaToday")
    }

    static func launchDate() -> CivilDate? {
        let args = ProcessInfo.processInfo.arguments
        guard let flag = args.firstIndex(of: "--date"), args.indices.contains(flag + 1) else {
            return nil
        }
        let parts = args[flag + 1].split(separator: "-").compactMap { Int($0) }
        guard parts.count == 3 else { return nil }
        let civil = CivilDate(year: parts[0], month: parts[1], day: parts[2])
        return civil.isInPublishedRange ? civil : nil
    }
}
