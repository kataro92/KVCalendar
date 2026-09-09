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
        VStack(alignment: .leading, spacing: DesignTokens.spaceSM) {
            Text(CalendarAccessibility.sheetSummary(day: day, occurrences: occurrences, personalTitles: personalTitles))
                .frame(width: 0, height: 0)
                .accessibilityIdentifier("day-summary")
                .accessibilityAddTraits(.isHeader)
                .accessibilityHidden(false)
            Text(CalendarDayFormatter.solarDay(day))
                .font(.system(size: LargePrintLayout.solarDayPointSize(typeSize), weight: .medium, design: .serif))
                .monospacedDigit()
                .foregroundStyle(DesignTokens.ink)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .accessibilityLabel("Ngày dương \(day.civilDate.day)")
                .accessibilityIdentifier("solar-day")
            Text(CalendarDayFormatter.weekday(day))
                .font(.headline)
                .foregroundStyle(DesignTokens.inkSecondary)
            Text(CalendarDayFormatter.solarMonthYear(day))
                .foregroundStyle(DesignTokens.inkSecondary)
            Text(CalendarDayFormatter.lunar(day))
                .font(.title3)
                .foregroundStyle(DesignTokens.ink)
                .accessibilityIdentifier("lunar-day")
            if let term = day.solarTerm {
                Text(term.name)
                    .foregroundStyle(DesignTokens.son)
            }
            ForEach(occurrences, id: \.id) { item in
                Text("\(item.title) · \(item.taxonomy.displayName)")
                    .font(.subheadline)
                    .accessibilityIdentifier("front-occurrence-\(item.id)")
            }
            ForEach(personalTitles, id: \.self) { title in
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(DesignTokens.sonDeep)
            }
            if let scene = CalendarAccessibility.sceneDescription(cueID: sceneCueID) {
                Text(scene)
                    .font(.footnote)
                    .foregroundStyle(DesignTokens.inkSecondary)
                    .accessibilityIdentifier("scene-description")
            }
            if LargePrintLayout.showsSecondaryOnFront(typeSize) {
                Text(CalendarDayFormatter.canChiDay(day))
                    .foregroundStyle(DesignTokens.inkSecondary)
                    .accessibilityIdentifier("can-chi-front")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .contain)
    }
}
