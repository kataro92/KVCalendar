import SwiftUI
import ContentCore

struct WidgetBlocView: View {
    var snapshot: WidgetSnapshot
    var isToday: Bool
    var lockScreen: Bool
    var compact: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: compact ? 2 : 6) {
            if isToday {
                Text("Hôm nay")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(DesignTokens.son)
                    .accessibilityIdentifier("widget-today-caption")
            }
            Text("\(snapshot.civilDay)")
                .font(compact ? .title : .largeTitle)
                .fontWeight(.medium)
                .monospacedDigit()
                .foregroundStyle(DesignTokens.ink)
                .accessibilityLabel("Ngày dương \(snapshot.civilDay)")
                .accessibilityIdentifier("widget-solar-day")
            Text(lunarLine)
                .font(.caption)
                .foregroundStyle(DesignTokens.inkSecondary)
                .accessibilityIdentifier("widget-lunar-day")
            if let publicLabel = snapshot.publicOccurrenceLabel, !compact {
                Text(publicLabel)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(DesignTokens.sonDeep)
                    .lineLimit(1)
                    .accessibilityIdentifier("widget-public-event")
            }
            if let personal = WidgetPrivacyFilter.visiblePersonalLabel(
                snapshot.personalHomeLabel,
                lockScreen: lockScreen
            ), !compact {
                Text(personal)
                    .font(.caption)
                    .foregroundStyle(DesignTokens.inkSecondary)
                    .lineLimit(1)
                    .accessibilityIdentifier("widget-personal-marker")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .accessibilityElement(children: .combine)
    }

    private var lunarLine: String {
        let leap = snapshot.lunarIsLeap ? " nhuận" : ""
        return "Âm lịch \(snapshot.lunarDay) tháng \(snapshot.lunarMonth)\(leap)"
    }
}
