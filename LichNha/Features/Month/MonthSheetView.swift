import SwiftUI
import CalendarCore
import ContentCore

struct MonthSheetView: View {
    @Bindable var session: AppSession
    @Environment(\.dynamicTypeSize) private var typeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast
    @Environment(\.legibilityWeight) private var legibilityWeight

    var body: some View {
        CalendarMountView(headerTitle: "LỊCH THÁNG") {
            ScrollView {
                VStack(spacing: DesignTokens.spaceMD) {
                    MountedPaperPage {
                        monthHeader

                        if typeSize >= .accessibility2 {
                            monthList
                        } else {
                            calendarPaper
                        }
                    }

                    Button(action: session.closeMonthWithoutChangingDate) {
                        Label("Quay lại tờ ngày", systemImage: "calendar.day.timeline.left")
                    }
                    .lichNhaHitTarget()
                    .buttonStyle(PaperControlStyle())
                    .accessibilityIdentifier("back-to-day")
                }
                .padding(.top, 6)
                .padding(.bottom, DesignTokens.spaceLG)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }

    private var monthHeader: some View {
        HStack(spacing: DesignTokens.spaceSM) {
            monthArrow(
                systemName: "chevron.left",
                label: "Tháng trước",
                identifier: "previous-month",
                delta: -1
            )

            VStack(spacing: 3) {
                Text(MonthGridModel.title(year: session.monthYear, month: session.monthMonth))
                    .font(.system(.title2, design: .rounded).weight(.bold))
                    .foregroundStyle(DesignTokens.ink)
                    .lineLimit(1)
                    .minimumScaleFactor(0.78)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityIdentifier("month-sheet")
            }
            .frame(maxWidth: .infinity)

            monthArrow(
                systemName: "chevron.right",
                label: "Tháng sau",
                identifier: "next-month",
                delta: 1
            )
        }
    }

    private func monthArrow(
        systemName: String,
        label: String,
        identifier: String,
        delta: Int
    ) -> some View {
        Button {
            if reduceMotion {
                session.shiftMonth(by: delta)
            } else {
                withAnimation(.easeOut(duration: DesignTokens.motionFast)) {
                    session.shiftMonth(by: delta)
                }
            }
        } label: {
            Image(systemName: systemName)
                .font(.body.weight(.semibold))
                .foregroundStyle(DesignTokens.ink)
                .frame(width: DesignTokens.minHitTarget, height: DesignTokens.minHitTarget)
                .background(DesignTokens.chipFill, in: Circle())
                .overlay {
                    Circle()
                        .stroke(DesignTokens.wood.opacity(0.20), lineWidth: 1)
                }
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
        .accessibilityIdentifier(identifier)
    }

    private var calendarPaper: some View {
        return VStack(spacing: 0) {
            weekdayHeader

            monthGrid
                .padding(.top, 8)
                .padding(.bottom, 10)

            Divider()
                .overlay(DesignTokens.wood.opacity(0.16))

            markerLegend
                .padding(.vertical, 10)
        }
    }

    private var weekdayHeader: some View {
        HStack(spacing: 2) {
            ForEach(Array(MonthGridModel.weekdayLabels.enumerated()), id: \.offset) { index, label in
                Text(label)
                    .font(.caption.weight(index == 6 ? .bold : .semibold))
                    .foregroundStyle(index == 6 ? DesignTokens.son : DesignTokens.inkSecondary)
                    .frame(maxWidth: .infinity, minHeight: 34)
                    .accessibilityLabel(MonthGridModel.weekdaySpokenNames[index])
            }
        }
        .padding(.top, 4)
        .background(DesignTokens.peach.opacity(0.30))
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: DesignTokens.radiusSheet - 1,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: DesignTokens.radiusSheet - 1,
                style: .continuous
            )
        )
    }

    @ViewBuilder
    private var monthGrid: some View {
        let cells = (try? MonthGridModel.cells(
            year: session.monthYear,
            month: session.monthMonth,
            markersForDay: markers(for:)
        )) ?? []
        let visibleCells = cells.count == 42 && cells.suffix(7).allSatisfy({ !$0.isInMonth })
            ? Array(cells.dropLast(7))
            : cells
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7),
            spacing: 2
        ) {
            ForEach(Array(visibleCells.enumerated()), id: \.offset) { index, cell in
                monthCell(cell, weekdayIndex: index % 7)
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
        return VStack(alignment: .leading, spacing: 8) {
            Text("Chọn một ngày để mở tờ lịch")
                .font(.subheadline)
                .foregroundStyle(DesignTokens.inkSecondary)
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(Array(cells.enumerated()), id: \.offset) { _, cell in
                    Button {
                        session.selectDate(cell.civil)
                    } label: {
                        HStack {
                            Text("Ngày \(cell.civil.day)")
                                .font(.body.weight(.semibold))
                            Spacer()
                            Text("Âm \(MonthGridModel.shortLunar(cell))")
                                .foregroundStyle(DesignTokens.inkSecondary)
                        }
                        .padding(.horizontal, 14)
                        .frame(maxWidth: .infinity, minHeight: DesignTokens.minHitTarget, alignment: .leading)
                        .background(DesignTokens.paper, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .disabled(!cell.isSelectable)
                    .accessibilityIdentifier("day-cell-\(cell.civil.day)")
                }
            }
        }
    }

    @ViewBuilder
    private func monthCell(_ cell: MonthCell, weekdayIndex: Int) -> some View {
        let inMonth = cell.isInMonth
        let selected = isSelected(cell)
        Group {
            if inMonth {
                Button {
                    guard cell.isSelectable else { return }
                    session.selectDate(cell.civil)
                } label: {
                    monthCellLabel(cell, selected: selected, isSunday: weekdayIndex == 6)
                }
                .buttonStyle(.plain)
                .disabled(!cell.isSelectable)
                .accessibilityLabel(cellLabel(cell))
                .accessibilityAddTraits(selected ? .isSelected : [])
                .accessibilityIdentifier("day-cell-\(cell.civil.day)")
            } else {
                monthCellLabel(cell, selected: false, isSunday: weekdayIndex == 6)
                    .opacity(0.34)
                    .accessibilityHidden(true)
            }
        }
    }

    private func monthCellLabel(_ cell: MonthCell, selected: Bool, isSunday: Bool) -> some View {
        VStack(spacing: 1) {
            Text("\(cell.civil.day)")
                .font(.system(.body, design: .rounded).weight(.semibold))
                .monospacedDigit()
            Text(MonthGridModel.shortLunar(cell))
                .font(.caption2)
                .foregroundStyle(selected ? DesignTokens.paper.opacity(0.88) : DesignTokens.inkSecondary)
            HStack(spacing: 2) {
                ForEach(cell.markers.prefix(3), id: \.self) { marker in
                    Circle()
                        .fill(selected ? DesignTokens.paper.opacity(0.88) : markerColor(marker))
                        .frame(width: 4, height: 4)
                        .accessibilityHidden(true)
                }
            }
            .frame(height: 5)
        }
        .frame(maxWidth: .infinity, minHeight: 48)
        .foregroundStyle(selected ? DesignTokens.paper : (isSunday ? DesignTokens.sonDeep : DesignTokens.ink))
        .background {
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(selected ? DesignTokens.son : (cell.isInMonth ? DesignTokens.chipFill.opacity(0.34) : Color.clear))
                .padding(.horizontal, 1)
        }
        .contentShape(Rectangle())
    }

    private var markerLegend: some View {
        HStack(spacing: 12) {
            legendItem(color: DesignTokens.son, title: "Ngày nghỉ")
            legendItem(color: DesignTokens.jade, title: "Ngày lễ")
            legendItem(color: DesignTokens.wood, title: "Tiết khí")
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Chú giải: đỏ là ngày nghỉ, xanh là ngày lễ, nâu là tiết khí")
    }

    private func legendItem(color: Color, title: String) -> some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 6, height: 6)
                .accessibilityHidden(true)
            Text(title)
                .font(.caption2.weight(.medium))
                .foregroundStyle(DesignTokens.inkSecondary)
                .lineLimit(1)
        }
    }

    private func isSelected(_ cell: MonthCell) -> Bool {
        cell.civil == session.selectedDate
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
