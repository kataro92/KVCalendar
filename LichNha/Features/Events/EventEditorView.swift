import SwiftUI
import CalendarCore
import PersonalCore
import ReminderCore

struct EventEditorView: View {
    @Bindable var session: AppSession
    @State private var validationMessage: String?
    @State private var showingCalendarExport = false

    var body: some View {
        CalendarMountView(headerTitle: session.editingIsNew ? "THÊM NGÀY NHÀ" : "SỬA NGÀY NHÀ") {
            ScrollView {
                MountedPaperPage {
                    Text(session.editingIsNew ? "Thêm một ngày để cả nhà cùng nhớ" : "Sửa ngày gia đình")
                        .font(.system(.title3, design: .rounded).weight(.bold))
                        .foregroundStyle(DesignTokens.ink)
                        .accessibilityIdentifier("event-editor")

                    if let message = validationMessage {
                        Text(message)
                            .foregroundStyle(DesignTokens.son)
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityIdentifier("event-editor-error")
                    }

                    PaperSection(title: "Tên ngày", symbol: "pencil.line") {
                        TextField("Tên sự kiện", text: Binding(
                            get: { session.eventDraft?.title ?? "" },
                            set: { newValue in session.mutateDraft { $0.title = newValue } }
                        ))
                        .padding(.horizontal, 12)
                        .frame(minHeight: DesignTokens.minHitTarget)
                        .background(DesignTokens.paper, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(DesignTokens.wood.opacity(0.18), lineWidth: 0.8))
                        .accessibilityIdentifier("event-title-field")
                    }

                    PaperSection(title: "Ngày diễn ra", symbol: "calendar") {
                        basisPicker
                        if session.eventDraft?.calendarBasis == .lunar {
                            lunarFields
                        } else {
                            solarFields
                        }
                    }

                    PaperSection(title: "Lặp và nhắc", symbol: "bell") {
                        recurrenceRow
                        reminderFields
                    }

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

                    Button("Lưu ngày này") { save() }
                        .buttonStyle(PaperPrimaryButtonStyle())
                        .lichNhaHitTarget()
                        .accessibilityIdentifier("save-event")

                    Button("Đóng") { session.closeEventEditor() }
                        .lichNhaHitTarget()
                        .buttonStyle(PaperControlStyle())
                        .accessibilityIdentifier("close-editor")
                }
                .padding(.top, 6)
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
        HStack(spacing: 8) {
            PaperChoiceButton(title: "Âm lịch", selected: session.eventDraft?.calendarBasis == .lunar, identifier: "basis-lunar") {
                session.mutateDraft { $0.calendarBasis = .lunar }
            }
            PaperChoiceButton(title: "Dương lịch", selected: session.eventDraft?.calendarBasis == .solar, identifier: "basis-solar") {
                session.mutateDraft { $0.calendarBasis = .solar }
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
            .tint(DesignTokens.son)
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
            Text("Lặp lại")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(DesignTokens.inkSecondary)
            HStack(spacing: 8) {
                PaperChoiceButton(title: "Hằng năm", selected: session.eventDraft?.recurrence == .yearly, identifier: "recurrence-yearly") {
                    session.mutateDraft { $0.recurrence = .yearly }
                }
                PaperChoiceButton(title: "Một lần", selected: session.eventDraft?.recurrence == .none, identifier: "recurrence-none") {
                    session.mutateDraft { $0.recurrence = .none }
                }
            }
        }
    }

    private var reminderFields: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle("Bật lời nhắc", isOn: Binding(
                get: { session.eventDraft?.reminderPolicy.enabled ?? true },
                set: { enabled in session.mutateDraft { $0.reminderPolicy.enabled = enabled } }
            ))
            .tint(DesignTokens.son)
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
        HStack(spacing: 10) {
            Text(title)
                .font(.subheadline.weight(.medium))
            Spacer()
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
            .buttonStyle(PaperStepperButtonStyle())
        }
        .padding(.leading, 4)
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
        CalendarMountView(headerTitle: "NGÀY GIA ĐÌNH") {
            ScrollView {
                MountedPaperPage {
                    Text("Những ngày nhà mình muốn nhớ")
                        .font(.system(.title3, design: .rounded).weight(.bold))
                        .foregroundStyle(DesignTokens.ink)
                        .accessibilityIdentifier("event-list")
                    if session.personalEvents.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "calendar.badge.plus")
                                .font(.system(size: 36, weight: .light))
                                .foregroundStyle(DesignTokens.son.opacity(0.72))
                                .accessibilityHidden(true)
                            Text("Chưa có ngày nào được ghim")
                                .font(.system(.headline, design: .rounded).weight(.semibold))
                                .foregroundStyle(DesignTokens.ink)
                            Text("Thêm sinh nhật, ngày giỗ hoặc một dịp riêng của gia đình.")
                                .font(.subheadline)
                                .foregroundStyle(DesignTokens.inkSecondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 34)
                        .padding(.horizontal, 16)
                        .background(DesignTokens.peach.opacity(0.24), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    } else {
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
                                    .padding(14)
                                    .background(DesignTokens.jade.opacity(0.30), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(DesignTokens.wood.opacity(0.10), lineWidth: 0.7))
                                }
                                .lichNhaHitTarget()
                                .accessibilityIdentifier("personal-event-\(event.id)")
                            }
                        }
                    }
                    Button("Thêm ngày gia đình") { session.openNewEventEditor() }
                    .buttonStyle(PaperPrimaryButtonStyle())
                    .lichNhaHitTarget()
                    .accessibilityIdentifier("add-event-button")
                    Button("Quay lại tờ ngày") { session.closeEvents() }
                        .lichNhaHitTarget()
                        .buttonStyle(PaperControlStyle())
                        .accessibilityIdentifier("close-events")
                }
                .padding(.top, 6)
                .padding(.bottom, 20)
            }
        }
        .task { session.reloadPersonalEvents() }
    }
}
