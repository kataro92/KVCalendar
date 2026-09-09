import SwiftUI
import CalendarCore
import PersonalCore
import ReminderCore

struct EventEditorView: View {
    @Bindable var session: AppSession
    @State private var validationMessage: String?
    @State private var showingCalendarExport = false

    var body: some View {
        CalendarMountView {
            ScrollView {
                VStack(alignment: .leading, spacing: DesignTokens.spaceMD) {
                    Text(session.editingIsNew ? "Thêm ngày gia đình" : "Sửa ngày gia đình")
                        .font(.headline)
                        .accessibilityIdentifier("event-editor")

                    if let message = validationMessage {
                        Text(message)
                            .foregroundStyle(DesignTokens.son)
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityIdentifier("event-editor-error")
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tên sự kiện")
                        TextField("Tên sự kiện", text: Binding(
                            get: { session.eventDraft?.title ?? "" },
                            set: { newValue in session.mutateDraft { $0.title = newValue } }
                        ))
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("event-title-field")
                    }

                    basisPicker
                    if session.eventDraft?.calendarBasis == .lunar {
                        lunarFields
                    } else {
                        solarFields
                    }

                    recurrenceRow
                    reminderFields

                    if session.eventDraft?.calendarBasis == .lunar, session.eventDraft?.recurrence == .yearly {
                        LeapMonthPolicyView(
                            policy: leapBinding,
                            month: session.eventDraft?.originLunarDate?.month ?? 8
                        )
                    }
                    if session.eventDraft?.calendarBasis == .lunar, session.eventDraft?.originLunarDate?.day == 30 {
                        ShortMonthPolicyView(policy: shortBinding)
                    }

                    if let draft = session.eventDraft {
                        Text(EventPolicySummary.text(draft))
                            .font(.subheadline)
                            .foregroundStyle(DesignTokens.ink)
                            .accessibilityIdentifier("policy-summary")
                    }

                    if session.lastSaveSucceeded {
                        EventReminderStatusView(
                            saved: true,
                            reminderEnabled: session.eventDraft?.reminderPolicy.enabled ?? true,
                            permission: session.notificationPermission,
                            eventStatus: session.lastSavedStatus
                        )
                        Button("Thêm vào Lịch iPhone") { showingCalendarExport = true }
                            .lichNhaHitTarget()
                            .accessibilityIdentifier("export-iphone-calendar")
                    }

                    Button("Lưu") { save() }
                        .buttonStyle(.borderedProminent)
                        .tint(DesignTokens.son)
                        .lichNhaHitTarget()
                        .accessibilityIdentifier("save-event")

                    Button("Đóng") { session.closeEventEditor() }
                        .lichNhaHitTarget()
                        .accessibilityIdentifier("close-editor")
                }
                .padding(.bottom, 24)
            }
        }
        .sheet(isPresented: $showingCalendarExport) {
            if let draft = session.eventDraft, let civil = exportCivil(draft) {
                SystemCalendarExportSheet(title: draft.title, civil: civil) {
                    showingCalendarExport = false
                }
            }
        }
    }

    private var leapBinding: Binding<LeapMonthPolicy> {
        Binding(
            get: { session.eventDraft?.leapMonthPolicy ?? .regularMonth },
            set: { newValue in session.mutateDraft { $0.leapMonthPolicy = newValue } }
        )
    }

    private var shortBinding: Binding<ShortMonthPolicy> {
        Binding(
            get: { session.eventDraft?.shortMonthPolicy ?? .lastDayOfMonth },
            set: { newValue in session.mutateDraft { $0.shortMonthPolicy = newValue } }
        )
    }

    private var basisPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hệ lịch")
                .font(.headline)
            HStack {
                Button("Âm lịch") { session.mutateDraft { $0.calendarBasis = .lunar } }
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("basis-lunar")
                    .buttonStyle(.bordered)
                    .tint(session.eventDraft?.calendarBasis == .lunar ? DesignTokens.wood : DesignTokens.inkSecondary)
                Button("Dương lịch") { session.mutateDraft { $0.calendarBasis = .solar } }
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("basis-solar")
                    .buttonStyle(.bordered)
                    .tint(session.eventDraft?.calendarBasis == .solar ? DesignTokens.wood : DesignTokens.inkSecondary)
            }
        }
    }

    private var lunarFields: some View {
        VStack(alignment: .leading, spacing: 8) {
            stepperRow(
                title: "Ngày âm",
                value: Binding(
                    get: { session.eventDraft?.originLunarDate?.day ?? 12 },
                    set: { session.updateLunarDay($0) }
                ),
                range: 1...30,
                identifier: "lunar-day-field"
            )
            stepperRow(
                title: "Tháng âm",
                value: Binding(
                    get: { session.eventDraft?.originLunarDate?.month ?? 8 },
                    set: { session.updateLunarMonth($0) }
                ),
                range: 1...12,
                identifier: "lunar-month-field"
            )
            Toggle("Ngày gốc thuộc tháng nhuận", isOn: Binding(
                get: { session.eventDraft?.originLunarDate?.isLeapMonth ?? false },
                set: { session.updateLunarLeap($0) }
            ))
            .accessibilityIdentifier("origin-leap-toggle")
        }
    }

    private var solarFields: some View {
        VStack(alignment: .leading, spacing: 8) {
            stepperRow(
                title: "Ngày dương",
                value: Binding(
                    get: { session.eventDraft?.originCivilDate?.day ?? 1 },
                    set: { session.updateSolarDay($0) }
                ),
                range: 1...31,
                identifier: "solar-day-field"
            )
            stepperRow(
                title: "Tháng dương",
                value: Binding(
                    get: { session.eventDraft?.originCivilDate?.month ?? 1 },
                    set: { session.updateSolarMonth($0) }
                ),
                range: 1...12,
                identifier: "solar-month-field"
            )
        }
    }

    private var recurrenceRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Lặp")
                .font(.headline)
            HStack {
                Button("Hằng năm") { session.mutateDraft { $0.recurrence = .yearly } }
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("recurrence-yearly")
                    .buttonStyle(.bordered)
                Button("Một lần") { session.mutateDraft { $0.recurrence = .none } }
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("recurrence-none")
                    .buttonStyle(.bordered)
            }
        }
    }

    private var reminderFields: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Bật lời nhắc", isOn: Binding(
                get: { session.eventDraft?.reminderPolicy.enabled ?? true },
                set: { enabled in session.mutateDraft { $0.reminderPolicy.enabled = enabled } }
            ))
            .accessibilityIdentifier("reminder-enabled")
            stepperRow(
                title: "Nhắc trước (ngày)",
                value: Binding(
                    get: { session.eventDraft?.reminderPolicy.leadDays ?? 3 },
                    set: { days in session.mutateDraft { $0.reminderPolicy.leadDays = min(30, max(0, days)) } }
                ),
                range: 0...30,
                identifier: "reminder-lead-field"
            )
            stepperRow(
                title: "Giờ",
                value: Binding(
                    get: { session.eventDraft?.reminderPolicy.hour ?? 8 },
                    set: { hour in session.mutateDraft { $0.reminderPolicy.hour = min(23, max(0, hour)) } }
                ),
                range: 0...23,
                identifier: "reminder-hour-field"
            )
        }
    }

    private func stepperRow(title: String, value: Binding<Int>, range: ClosedRange<Int>, identifier: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
            HStack {
                Button("−") { value.wrappedValue = max(range.lowerBound, value.wrappedValue - 1) }
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("\(identifier)-minus")
                Text("\(value.wrappedValue)")
                    .monospacedDigit()
                    .frame(minWidth: 44)
                    .accessibilityIdentifier(identifier)
                Button("+") { value.wrappedValue = min(range.upperBound, value.wrappedValue + 1) }
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("\(identifier)-plus")
            }
            .buttonStyle(.bordered)
        }
    }

    private func save() {
        let title = session.eventDraft?.title.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if title.isEmpty {
            validationMessage = "Nhập tên sự kiện."
            return
        }
        validationMessage = nil
        Task { await session.saveDraft() }
    }

    private func exportCivil(_ event: PersonalEvent) -> CivilDate? {
        ReminderPlanner.targetCivilDates(
            event: event,
            windowStart: CivilDate(year: 2024, month: 1, day: 1),
            windowEnd: CivilDate(year: 2027, month: 12, day: 31)
        ).first ?? event.originCivilDate
    }
}

struct EventListView: View {
    @Bindable var session: AppSession

    var body: some View {
        CalendarMountView {
            VStack(alignment: .leading, spacing: DesignTokens.spaceMD) {
                Text("Ngày gia đình")
                    .font(.headline)
                    .accessibilityIdentifier("event-list")
                if session.personalEvents.isEmpty {
                    Text("Chưa có sự kiện trên máy này.")
                        .foregroundStyle(DesignTokens.inkSecondary)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(session.personalEvents) { event in
                                Button {
                                    session.openEventEditor(event)
                                } label: {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(event.title)
                                            .font(.headline)
                                            .foregroundStyle(DesignTokens.ink)
                                        Text(EventPolicySummary.text(event))
                                            .font(.footnote)
                                            .foregroundStyle(DesignTokens.inkSecondary)
                                            .lineLimit(3)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(DesignTokens.spaceSM)
                                    .background(DesignTokens.jade.opacity(0.35), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                }
                                .lichNhaHitTarget()
                                .accessibilityIdentifier("personal-event-\(event.id)")
                            }
                        }
                    }
                }
                Button("Thêm ngày gia đình") { session.openNewEventEditor() }
                    .buttonStyle(.borderedProminent)
                    .tint(DesignTokens.son)
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("add-event-button")
                Button("Quay lại tờ ngày") { session.closeEvents() }
                    .lichNhaHitTarget()
                    .buttonStyle(PaperControlStyle())
                    .accessibilityIdentifier("close-events")
            }
        }
        .task { session.reloadPersonalEvents() }
    }
}
