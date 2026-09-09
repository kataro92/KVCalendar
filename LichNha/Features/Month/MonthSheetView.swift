import SwiftUI
import CalendarCore
import ContentCore

struct MonthSheetView: View {
    @Bindable var session: AppSession
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        CalendarMountView {
            ScrollView {
                VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
                    HStack {
                        Button("Tháng trước") { session.shiftMonth(by: -1) }
                            .lichNhaHitTarget()
                            .accessibilityIdentifier("previous-month")
                        Spacer()
                        Text(MonthGridModel.title(year: session.monthYear, month: session.monthMonth))
                            .font(.headline)
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityIdentifier("month-sheet")
                        Spacer()
                        Button("Tháng sau") { session.shiftMonth(by: 1) }
                            .lichNhaHitTarget()
                            .accessibilityIdentifier("next-month")
                    }
                    .buttonStyle(PaperControlStyle())

                    if typeSize >= .accessibility2 {
                        monthList
                    } else {
                        monthGrid
                    }

                    Button("Quay lại tờ ngày") { session.closeMonthWithoutChangingDate() }
                        .lichNhaHitTarget()
                        .buttonStyle(PaperControlStyle())
                        .accessibilityIdentifier("back-to-day")
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }

    @ViewBuilder
    private var monthGrid: some View {
        let cells = (try? MonthGridModel.cells(
            year: session.monthYear,
            month: session.monthMonth,
            markersForDay: markers(for:)
        )) ?? []
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 7),
            spacing: 8
        ) {
            ForEach(Array(MonthGridModel.weekdayLabels.enumerated()), id: \.offset) { index, label in
                Text(label)
                    .font(.caption)
                    .foregroundStyle(DesignTokens.inkSecondary)
                    .frame(maxWidth: .infinity)
                    .accessibilityLabel(MonthGridModel.weekdaySpokenNames[index])
            }
            ForEach(Array(cells.enumerated()), id: \.offset) { _, cell in
                monthCell(cell)
            }
        }
        .accessibilityIdentifier("month-grid")
    }

    private var monthList: some View {
        let cells = ((try? MonthGridModel.cells(
            year: session.monthYear,
            month: session.monthMonth,
            markersForDay: markers(for:)
        )) ?? []).filter(\.isInMonth)
        return ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(cells.enumerated()), id: \.offset) { _, cell in
                    Button {
                        session.selectDate(cell.civil)
                    } label: {
                        Text("Ngày \(cell.civil.day), âm \(MonthGridModel.shortLunar(cell))")
                            .frame(maxWidth: .infinity, minHeight: DesignTokens.minHitTarget, alignment: .leading)
                    }
                    .disabled(!cell.isSelectable)
                    .accessibilityIdentifier("day-cell-\(cell.civil.day)")
                }
            }
        }
    }

    @ViewBuilder
    private func monthCell(_ cell: MonthCell) -> some View {
        let inMonth = cell.isInMonth
        Button {
            guard cell.isSelectable, inMonth else { return }
            session.selectDate(cell.civil)
        } label: {
            VStack(spacing: 2) {
                Text("\(cell.civil.day)")
                    .font(.headline)
                    .monospacedDigit()
                Text(MonthGridModel.shortLunar(cell))
                    .font(.caption2)
                    .foregroundStyle(DesignTokens.inkSecondary)
                HStack(spacing: 3) {
                    ForEach(cell.markers, id: \.self) { marker in
                        Circle()
                            .fill(markerColor(marker))
                            .frame(width: 5, height: 5)
                            .accessibilityHidden(true)
                    }
                }
                .frame(height: 6)
            }
            .frame(maxWidth: .infinity, minHeight: DesignTokens.minHitTarget)
            .foregroundStyle(inMonth ? DesignTokens.ink : DesignTokens.inkSecondary.opacity(0.45))
            .opacity(inMonth ? 1 : 0.7)
        }
        .disabled(!cell.isSelectable || !inMonth)
        .accessibilityLabel(cellLabel(cell))
        .accessibilityIdentifier(inMonth ? "day-cell-\(cell.civil.day)" : "day-cell-out-\(cell.civil.day)")
    }

    private func markers(for day: CalendarDay) -> [MonthMarker] {
        guard let catalog = session.catalog else { return [] }
        var result: [MonthMarker] = []
        for occurrence in catalog.occurrences(on: day) {
            switch occurrence.taxonomy {
            case .statutoryHoliday:
                result.append(.statutory)
            case .traditionalLunar, .localFestival:
                result.append(.traditional)
            default:
                break
            }
        }
        return result
    }

    private func markerColor(_ marker: MonthMarker) -> Color {
        switch marker {
        case .statutory: DesignTokens.son
        case .traditional: DesignTokens.jade
        case .solarTerm: DesignTokens.wood
        case .historical: DesignTokens.bronze
        }
    }

    private func cellLabel(_ cell: MonthCell) -> String {
        guard cell.isInMonth else { return "Ngày ngoài tháng" }
        var parts = ["Ngày dương \(cell.civil.day)", "âm \(MonthGridModel.shortLunar(cell))"]
        if cell.markers.contains(.statutory) { parts.append("ngày nghỉ theo luật") }
        if cell.markers.contains(.traditional) { parts.append("lễ truyền thống") }
        return parts.joined(separator: ", ")
    }
}
