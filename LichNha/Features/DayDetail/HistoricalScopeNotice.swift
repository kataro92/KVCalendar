import SwiftUI
import CalendarCore

struct HistoricalScopeNotice: View {
    var civil: CivilDate

    var body: some View {
        if let message = HistoricalCalendarScope.warningMessage(for: civil) {
            let scope = HistoricalCalendarScope.scope(for: civil)
            VStack(alignment: .leading, spacing: 4) {
                Text(scopeTitle(scope))
                    .font(.subheadline.weight(.semibold))
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(DesignTokens.inkSecondary)
            }
            .padding(DesignTokens.spaceSM)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(DesignTokens.peach.opacity(0.5), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .accessibilityIdentifier("history-notice")
        }
    }

    private func scopeTitle(_ scope: HistoryScope) -> String {
        switch scope {
        case .modern: "Lịch hiện hành"
        case .documentedException: "Ngoại lệ 1968–1975"
        case .retrospective: "Hồi chiếu thiên văn"
        }
    }
}
