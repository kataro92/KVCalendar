import SwiftUI

struct TodayButton: View {
    var isHidden: Bool
    var action: () -> Void

    var body: some View {
        if !isHidden {
            Button("Hôm nay", action: action)
                .lichNhaHitTarget()
                .buttonStyle(.borderedProminent)
                .tint(DesignTokens.son)
                .accessibilityIdentifier("today-button")
        }
    }
}
