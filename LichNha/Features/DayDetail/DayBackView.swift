import SwiftUI
import CalendarCore
import ContentCore
import AlmanacCore

struct DayBackView: View {
    @Bindable var session: AppSession

    var body: some View {
        CalendarMountView {
            ScrollView {
                VStack(alignment: .leading, spacing: DesignTokens.spaceMD) {
                    if let day = session.day {
                        Text("Mặt sau")
                            .font(.headline)
                            .accessibilityIdentifier("day-back")
                        Text(CalendarDayFormatter.solarMonthYear(day) + ", ngày \(day.civilDate.day)")
                        Text(CalendarDayFormatter.lunar(day))
                        Text("Can Chi: \(CalendarDayFormatter.canChiDay(day))")
                            .accessibilityIdentifier("can-chi-back")
                        if let term = day.solarTerm {
                            Text("Tiết khí: \(term.name)")
                        }
                        Text("Công cụ lịch \(day.engineVersion)")
                            .font(.footnote)
                            .foregroundStyle(DesignTokens.inkSecondary)

                        HistoricalScopeNotice(civil: day.civilDate)

                        occurrenceBlock(day)
                        if session.almanacVisible {
                            almanacBlock(day)
                        }
                    }
                    Toggle(isOn: Binding(
                        get: { session.almanacVisible },
                        set: { session.setAlmanacVisible($0) }
                    )) {
                        Text("Hiện lớp lịch truyền thống")
                    }
                    .accessibilityIdentifier("almanac-toggle")
                    .tint(DesignTokens.wood)

                    Button("Quay lại tờ ngày") { session.closeDayBack() }
                        .lichNhaHitTarget()
                        .buttonStyle(PaperControlStyle())
                        .accessibilityIdentifier("back-to-day")
                    if session.canReturnToMonth {
                        Button("Quay lại tháng") { session.returnToMonth() }
                            .lichNhaHitTarget()
                            .buttonStyle(PaperControlStyle())
                            .accessibilityIdentifier("back-to-month")
                    }
                }
                .padding(.bottom, 16)
            }
        }
    }

    @ViewBuilder
    private func occurrenceBlock(_ day: CalendarDay) -> some View {
        let items = session.catalog?.occurrences(on: day) ?? []
        if items.isEmpty {
            Text("Không có ngày nghỉ hay lễ đóng gói cho ngày này.")
                .foregroundStyle(DesignTokens.inkSecondary)
        } else {
            ForEach(items, id: \.id) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .accessibilityIdentifier("occurrence-\(item.id)")
                    Text(item.taxonomy.displayName)
                        .font(.subheadline)
                    Text(item.isDayOff ? "Ngày nghỉ" : "Không phải ngày nghỉ theo luật")
                        .font(.footnote)
                    if let audience = item.audience {
                        Text(audience)
                            .font(.footnote)
                            .foregroundStyle(DesignTokens.inkSecondary)
                    }
                    if let citation = item.legalCitation {
                        Text(citation)
                            .font(.footnote)
                            .foregroundStyle(DesignTokens.inkSecondary)
                    }
                    if let sourceID = item.sourceID {
                        Button("Xem nguồn") { session.openSource(sourceID) }
                            .lichNhaHitTarget()
                            .accessibilityIdentifier("source-link-\(item.id)")
                    }
                }
                .padding(DesignTokens.spaceSM)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignTokens.sky.opacity(0.35), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
        }
    }

    @ViewBuilder
    private func almanacBlock(_ day: CalendarDay) -> some View {
        let entries = AlmanacEngine.entries(for: day)
        Text(AlmanacEngine.referenceLabel)
            .font(.subheadline.weight(.semibold))
            .accessibilityIdentifier("almanac-reference-label")
        Text("Bộ quy tắc \(AlmanacEngine.ruleset.id) · \(AlmanacEngine.ruleset.version)")
            .font(.footnote)
            .foregroundStyle(DesignTokens.inkSecondary)
        ForEach(AlmanacEngine.ruleset.methods, id: \.id) { method in
            let methodEntries = entries.filter { $0.methodID == method.id }
            VStack(alignment: .leading, spacing: 4) {
                Text(method.displayName)
                    .font(.headline)
                ForEach(methodEntries.prefix(method.id == "hoang-hac-dao" ? 12 : 2), id: \.label) { entry in
                    Text(entry.label)
                        .font(.footnote)
                }
                if let sourceID = method.sourceIDs.first {
                    Button("Nguồn \(method.displayName)") { session.openSource(sourceID) }
                        .lichNhaHitTarget()
                        .accessibilityIdentifier("almanac-source-\(method.id)")
                }
            }
            .padding(DesignTokens.spaceSM)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(DesignTokens.paper, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(DesignTokens.wood.opacity(0.25), lineWidth: 1)
            )
        }
    }
}
