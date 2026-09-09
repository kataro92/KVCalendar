import SwiftUI

struct PaperChoiceButton: View {
    var title: String
    var selected: Bool
    var identifier: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(selected ? DesignTokens.sonDeep : DesignTokens.ink)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(selected ? DesignTokens.peach.opacity(0.9) : DesignTokens.chipFill)
                )
                .overlay(
                    Capsule()
                        .stroke(selected ? DesignTokens.son.opacity(0.4) : DesignTokens.wood.opacity(0.2), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .lichNhaHitTarget()
        .accessibilityAddTraits(selected ? .isSelected : [])
        .accessibilityIdentifier(identifier)
    }
}
