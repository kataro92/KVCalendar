import SwiftUI

struct DayNavigationControls: View {
    var onPrevious: () -> Void
    var onNext: () -> Void

    var body: some View {
        HStack(spacing: DesignTokens.spaceMD) {
            Button("Ngày trước", action: onPrevious)
                .lichNhaHitTarget()
                .accessibilityIdentifier("previous-day")
            Spacer()
            Button("Ngày sau", action: onNext)
                .lichNhaHitTarget()
                .accessibilityIdentifier("next-day")
        }
        .buttonStyle(.bordered)
        .tint(DesignTokens.wood)
    }
}
