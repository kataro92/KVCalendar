import Foundation
import Testing
import CalendarCore
import PersonalCore
import ReminderCore

struct ReminderPlannerTests {
    private let gioMau = PersonalEvent(
        id: "gio-mau",
        title: "Ngày giỗ mẫu",
        calendarBasis: .lunar,
        originLunarDate: LunarDate(
            day: 12,
            month: 8,
            year: 2024,
            isLeapMonth: false,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        ),
        recurrence: .yearly,
        leapMonthPolicy: .regularMonth,
        reminderPolicy: ReminderPolicy(enabled: true, leadDays: 3, hour: 8, minute: 0)
    )

    @Test func statusCasesExist() {
        #expect(ReminderStatus.planned != .scheduled)
    }

    @Test func lunarAnniversaryUsesVietnamRuleZone() throws {
        let plan = ReminderPlanner.plan(
            event: gioMau,
            windowStart: CivilDate(year: 2024, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31),
            permission: .authorized
        )
        #expect(plan.occurrences.count >= 2)
        #expect(plan.eventStatus == .remindersActive)
        for item in plan.occurrences {
            let lunar = try VietnameseLunarCalendar.lunarDate(from: item.targetCivilDate)
            #expect(lunar.day == 12)
            #expect(lunar.month == 8)
            #expect(lunar.isLeapMonth == false)
            #expect(item.sourceRuleVersion == VietnameseLunarCalendar.ruleSetVersion)
        }
        let first = try #require(plan.occurrences.first)
        #expect(first.id == ReminderPlanner.occurrenceID(eventID: "gio-mau", target: first.targetCivilDate, leadDays: 3))
        let again = ReminderPlanner.plan(
            event: gioMau,
            windowStart: CivilDate(year: 2024, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31),
            permission: .authorized
        )
        #expect(plan.occurrences.map(\.id) == again.occurrences.map(\.id))
        #expect(plan.policySummary.contains("tháng Tám"))
        #expect(plan.policySummary.contains("trước 3 ngày"))
    }

    @Test func leapMonthPoliciesIn2004() throws {
        #expect(VietnameseLunarCalendar.leapMonthNumber(inLunarYear: 2004) == 2)
        let originLeap = LunarDate(
            day: 1,
            month: 2,
            year: 2004,
            isLeapMonth: true,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        )
        let windowStart = CivilDate(year: 2004, month: 1, day: 1)
        let windowEnd = CivilDate(year: 2005, month: 12, day: 31)

        func dates(_ policy: LeapMonthPolicy, origin: LunarDate) -> [CivilDate] {
            let event = PersonalEvent(
                id: "leap",
                title: "Ngày giỗ mẫu",
                calendarBasis: .lunar,
                originLunarDate: origin,
                recurrence: .yearly,
                leapMonthPolicy: policy,
                reminderPolicy: ReminderPolicy(enabled: true, leadDays: 0, hour: 8, minute: 0)
            )
            return ReminderPlanner.plan(
                event: event,
                windowStart: windowStart,
                windowEnd: windowEnd,
                permission: .authorized
            ).occurrences.filter { $0.targetCivilDate.year == 2004 }.map(\.targetCivilDate)
        }

        let regularOrigin = LunarDate(
            day: 1, month: 2, year: 2004, isLeapMonth: false,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        )
        #expect(dates(.regularMonth, origin: regularOrigin).count == 1)
        #expect(dates(.leapMonth, origin: originLeap).count == 1)
        #expect(dates(.both, origin: regularOrigin).count == 2)
        let substituteLeapYear = dates(.substitute, origin: originLeap)
        #expect(substituteLeapYear.count == 1)
        let leapCivil = try VietnameseLunarCalendar.civilDate(from: originLeap)
        #expect(substituteLeapYear.first == leapCivil)

        let substituteNonLeap = ReminderPlanner.plan(
            event: PersonalEvent(
                id: "leap",
                title: "Ngày giỗ mẫu",
                calendarBasis: .lunar,
                originLunarDate: originLeap,
                recurrence: .yearly,
                leapMonthPolicy: .substitute,
                reminderPolicy: ReminderPolicy(enabled: true, leadDays: 0, hour: 8, minute: 0)
            ),
            windowStart: CivilDate(year: 2005, month: 1, day: 1),
            windowEnd: CivilDate(year: 2005, month: 12, day: 31),
            permission: .authorized
        ).occurrences
        #expect(substituteNonLeap.count == 1)
        let lunar2005 = try VietnameseLunarCalendar.lunarDate(from: substituteNonLeap[0].targetCivilDate)
        #expect(lunar2005.month == 2)
        #expect(lunar2005.isLeapMonth == false)
    }

    @Test func shortMonthPolicies() throws {
        let sample = try firstShortMonth()
        let origin = LunarDate(
            day: 30,
            month: sample.month,
            year: sample.year,
            isLeapMonth: sample.isLeap,
            ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
        )
        let windowStart = CivilDate(year: sample.year, month: 1, day: 1)
        let windowEnd = CivilDate(year: sample.year, month: 12, day: 31)

        func plan(_ policy: ShortMonthPolicy) -> [ReminderOccurrence] {
            ReminderPlanner.plan(
                event: PersonalEvent(
                    id: "day30",
                    title: "Ngày giỗ mẫu",
                    calendarBasis: .lunar,
                    originLunarDate: origin,
                    recurrence: .none,
                    leapMonthPolicy: sample.isLeap ? .leapMonth : .regularMonth,
                    shortMonthPolicy: policy,
                    reminderPolicy: ReminderPolicy(enabled: true, leadDays: 0, hour: 8, minute: 0)
                ),
                windowStart: windowStart,
                windowEnd: windowEnd,
                permission: .authorized
            ).occurrences
        }

        #expect(plan(.skip).isEmpty)
        let last = try #require(plan(.lastDayOfMonth).first)
        let lastLunar = try VietnameseLunarCalendar.lunarDate(from: last.targetCivilDate)
        #expect(lastLunar.day == 29)
        #expect(lastLunar.month == sample.month)
        #expect(lastLunar.isLeapMonth == sample.isLeap)
        let next = try #require(plan(.firstOfNext).first)
        let nextLunar = try VietnameseLunarCalendar.lunarDate(from: next.targetCivilDate)
        #expect(nextLunar.day == 1)
    }

    @Test func permissionDeniedKeepsPlanWithoutSchedulingStatus() {
        let plan = ReminderPlanner.plan(
            event: gioMau,
            windowStart: CivilDate(year: 2026, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31),
            permission: .denied
        )
        #expect(plan.eventStatus == .permissionDenied)
        #expect(!plan.occurrences.isEmpty)
        #expect(plan.occurrences.allSatisfy { $0.status == .planned || $0.status == .failed })
    }

    @Test func deliveryZoneDoesNotMoveLunarDate() throws {
        var ny = gioMau
        ny.deliveryZone = TimeZoneIdentifier("America/New_York")
        ny.reminderPolicy.leadDays = 0
        let vn = ReminderPlanner.plan(
            event: gioMau,
            windowStart: CivilDate(year: 2026, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31),
            permission: .authorized
        )
        let abroad = ReminderPlanner.plan(
            event: ny,
            windowStart: CivilDate(year: 2026, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31),
            permission: .authorized
        )
        #expect(Set(vn.occurrences.map(\.targetCivilDate)) == Set(abroad.occurrences.map(\.targetCivilDate)))
        #expect(vn.occurrences.first?.deliveryDateTime != abroad.occurrences.first?.deliveryDateTime)
    }

    @Test func dstGapMovesToNextValidInstant() {
        let event = PersonalEvent(
            id: "dst-gap",
            title: "Ngày giỗ mẫu",
            calendarBasis: .solar,
            originCivilDate: CivilDate(year: 2026, month: 3, day: 8),
            recurrence: .none,
            reminderPolicy: ReminderPolicy(enabled: true, leadDays: 0, hour: 2, minute: 30),
            deliveryZone: TimeZoneIdentifier("America/New_York")
        )
        let plan = ReminderPlanner.plan(
            event: event,
            windowStart: CivilDate(year: 2026, month: 3, day: 1),
            windowEnd: CivilDate(year: 2026, month: 3, day: 31),
            permission: .authorized
        )
        let item = plan.occurrences[0]
        #expect(item.timeAdjustment == .dstGapNextValid)
        #expect(item.status != .failed)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "America/New_York")!
        #expect(calendar.component(.hour, from: item.deliveryDateTime) >= 3)
    }

    @Test func dstOverlapUsesEarlierInstant() {
        let event = PersonalEvent(
            id: "dst-overlap",
            title: "Ngày giỗ mẫu",
            calendarBasis: .solar,
            originCivilDate: CivilDate(year: 2026, month: 11, day: 1),
            recurrence: .none,
            reminderPolicy: ReminderPolicy(enabled: true, leadDays: 0, hour: 1, minute: 30),
            deliveryZone: TimeZoneIdentifier("America/New_York")
        )
        let plan = ReminderPlanner.plan(
            event: event,
            windowStart: CivilDate(year: 2026, month: 11, day: 1),
            windowEnd: CivilDate(year: 2026, month: 11, day: 2),
            permission: .authorized
        )
        let item = plan.occurrences[0]
        #expect(item.timeAdjustment == .dstOverlapEarlier)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "America/New_York")!
        #expect(calendar.component(.hour, from: item.deliveryDateTime) == 1)
        #expect(calendar.component(.minute, from: item.deliveryDateTime) == 30)
        #expect(calendar.timeZone.isDaylightSavingTime(for: item.deliveryDateTime))
    }

    @Test func schedulerIsIdempotentAndSkipsDeniedPermission() async throws {
        let scheduler = InMemoryNotificationScheduler(authorization: .denied)
        let plan = ReminderPlanner.plan(
            event: gioMau,
            windowStart: CivilDate(year: 2026, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31),
            permission: .denied
        )
        let first = try await NotificationScheduler.replace(plan.occurrences, on: scheduler, permission: .denied)
        #expect(await scheduler.pendingIdentifiers().isEmpty)
        #expect(first.allSatisfy { $0.systemIdentifier == nil })
        await scheduler.setAuthorization(.authorized)
        let scheduled = try await NotificationScheduler.replace(
            plan.occurrences,
            on: scheduler,
            permission: .authorized,
            now: Date(timeIntervalSince1970: 0)
        )
        let ids = await scheduler.pendingIdentifiers()
        #expect(ids.count == scheduled.count)
        let again = try await NotificationScheduler.replace(
            plan.occurrences,
            on: scheduler,
            permission: .authorized,
            now: Date(timeIntervalSince1970: 0)
        )
        #expect(await scheduler.pendingIdentifiers() == ids)
        #expect(Set(again.map(\.id)) == Set(scheduled.map(\.id)))
    }

    @Test @MainActor func refreshCoordinatorDoesNotDropEventWhenDenied() async throws {
        let container = try PersonalSchema.makeInMemoryContainer()
        let repository = PersonalEventRepository(container: container)
        try repository.upsert(gioMau)
        let scheduler = InMemoryNotificationScheduler(authorization: .denied)
        let coordinator = ReminderRefreshCoordinator(
            repository: repository,
            scheduler: scheduler,
            permission: .denied
        )
        try await coordinator.refresh(
            reason: .appActive,
            windowStart: CivilDate(year: 2026, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31)
        )
        #expect(try repository.event(id: "gio-mau") != nil)
        #expect(coordinator.lastPlans["gio-mau"]?.eventStatus == .permissionDenied)
        #expect(await scheduler.pendingIdentifiers().isEmpty)
        try await coordinator.refresh(
            reason: .timeZoneChange,
            windowStart: CivilDate(year: 2026, month: 1, day: 1),
            windowEnd: CivilDate(year: 2026, month: 12, day: 31)
        )
        #expect(coordinator.lastReason == .timeZoneChange)
        #expect(try repository.event(id: "gio-mau")?.originLunarDate?.month == 8)
    }

    private func firstShortMonth() throws -> (year: Int, month: Int, isLeap: Bool) {
        for year in 2000...2012 {
            for item in VietnameseLunarCalendar.months(inLunarYear: year) {
                let days = try VietnameseLunarCalendar.daysInMonth(
                    year: year,
                    month: item.month,
                    isLeap: item.isLeap
                )
                if days == 29 {
                    return (year, item.month, item.isLeap)
                }
            }
        }
        Issue.record("no 29-day lunar month found")
        return (2004, 2, false)
    }
}
