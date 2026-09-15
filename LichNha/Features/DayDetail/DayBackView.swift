import SwiftUI
import CalendarCore
import ContentCore
import AlmanacCore

struct DayBackView: View {
    @Bindable var session: AppSession

    var body: some View {
        CalendarMountView(headerTitle: "MẶT SAU TỜ LỊCH") {
            ScrollView {
                MountedPaperPage {
                    if let day = session.day {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(CalendarDayFormatter.solarMonthYear(day))
                                .font(.caption.weight(.bold))
                                .tracking(1.4)
                                .foregroundStyle(DesignTokens.son)
                            Text("Ngày \(day.civilDate.day)")
                                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                                .foregroundStyle(DesignTokens.ink)
                            Text(CalendarDayFormatter.lunar(day))
                                .font(.system(.title3, design: .rounded).weight(.medium))
                                .foregroundStyle(DesignTokens.inkSecondary)
                        }
                            .accessibilityIdentifier("day-back")

                        PaperSection(title: "Ngày âm", symbol: "moon.stars") {
                            Label("Can Chi: \(CalendarDayFormatter.canChiDay(day))", systemImage: "seal")
                                .accessibilityIdentifier("can-chi-back")
                            if let term = day.solarTerm {
                                Label("Tiết khí: \(term.name)", systemImage: "leaf")
                            }
                        }

                        HistoricalScopeNotice(civil: day.civilDate)

                        PaperSection(title: "Ngày lễ và ghi chú", symbol: "bookmark") {
                            occurrenceBlock(day)
                        }
                        if session.almanacVisible {
                            PaperSection(title: "Lịch truyền thống", symbol: "scroll") {
                                almanacBlock(day)
                            }
                        }
                        Text("Dữ liệu tính bởi công cụ lịch \(day.engineVersion)")
                            .font(.caption)
                            .foregroundStyle(DesignTokens.inkSecondary)
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
                .padding(.top, 6)
                .padding(.bottom, 20)
            }
        }
    }

    @ViewBuilder
    private func occurrenceBlock(_ day: CalendarDay) -> some View {
        let items = session.catalog?.occurrences(on: day) ?? []
        if items.isEmpty {
            Text("Hôm nay không có ngày lễ trong dữ liệu trên máy.")
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
            .font(.caption)
            .foregroundStyle(DesignTokens.inkSecondary)
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
