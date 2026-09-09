import SwiftUI
import CalendarCore
import ContentCore

struct TodayFrontView: View {
    var day: CalendarDay
    var occurrences: [CalendarOccurrence] = []
    var personalTitles: [String] = []
    var sceneCueID: String? = nil
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        VStack(spacing: 0) {
            Text(CalendarAccessibility.sheetSummary(day: day, occurrences: occurrences, personalTitles: personalTitles))
                .frame(width: 0, height: 0)
                .accessibilityIdentifier("day-summary")
                .accessibilityAddTraits(.isHeader)
                .accessibilityHidden(false)
            Text(CalendarDayFormatter.solarMonthHeadline(day))
                .font(.system(.caption, design: .rounded).weight(.semibold))
                .tracking(2.2)
                .foregroundStyle(DesignTokens.son)
                .padding(.top, 6)
                .accessibilityHidden(true)
            Rectangle()
                .fill(DesignTokens.son.opacity(0.62))
                .frame(width: 52, height: 1.5)
                .padding(.top, 8)
                .padding(.bottom, 10)
                .accessibilityHidden(true)
            Text(CalendarDayFormatter.weekdayAndYear(day))
                .font(.system(.subheadline, design: .rounded).weight(.medium))
                .foregroundStyle(DesignTokens.inkSecondary)
            Spacer(minLength: 4)
            Text(CalendarDayFormatter.solarDay(day))
                .font(.system(size: LargePrintLayout.solarDayPointSize(typeSize), weight: .bold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(day.weekday == 1 ? DesignTokens.son : DesignTokens.ink)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .accessibilityLabel("Ngày dương \(day.civilDate.day)")
                .accessibilityIdentifier("solar-day")
            Text(CalendarDayFormatter.lunarFront(day))
                .font(.system(.title3, design: .rounded).weight(.medium))
                .foregroundStyle(DesignTokens.ink)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .accessibilityIdentifier("lunar-day")
            if let term = day.solarTerm {
                Text(term.name)
                    .font(.system(.footnote, design: .rounded).weight(.semibold))
                    .foregroundStyle(DesignTokens.son)
                    .padding(.top, 8)
            }
            ForEach(occurrences, id: \.id) { item in
                Text(item.title)
                    .font(.system(.body, design: .rounded).weight(.semibold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 6)
                    .accessibilityIdentifier("front-occurrence-\(item.id)")
                    .accessibilityLabel("\(item.title) · \(item.taxonomy.displayName)")
            }
            ForEach(personalTitles, id: \.self) { title in
                Text(title)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(DesignTokens.sonDeep)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
            Spacer(minLength: 8)
            if LargePrintLayout.showsMotifOnFront(typeSize) {
                DayMotifView()
                    .stroke(DesignTokens.ink.opacity(0.52), style: StrokeStyle(lineWidth: 1.35, lineCap: .round, lineJoin: .round))
                    .frame(width: 44, height: 34)
                    .padding(.bottom, 6)
                    .accessibilityHidden(true)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .multilineTextAlignment(.center)
        .accessibilityElement(children: .contain)
        .accessibilityHint(CalendarAccessibility.sceneDescription(cueID: sceneCueID) ?? "")
    }
}

struct DayMotifView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let soil = CGRect(x: rect.midX - 7, y: rect.maxY - 5, width: 14, height: 4)
        path.addEllipse(in: soil)
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY - 4))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.minY + 2),
            control: CGPoint(x: rect.midX - 1.5, y: rect.midY)
        )
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 4))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + 2, y: rect.midY - 1),
            control: CGPoint(x: rect.midX - 11, y: rect.midY + 9)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.midY + 4),
            control: CGPoint(x: rect.midX - 8, y: rect.midY - 7)
        )
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 2))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - 2, y: rect.midY - 3),
            control: CGPoint(x: rect.midX + 11, y: rect.midY + 8)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.midY + 2),
            control: CGPoint(x: rect.midX + 8, y: rect.midY - 8)
        )
        return path
    }
}
