import SwiftUI

struct PaperChoiceButton: View {
    var title: String
    var selected: Bool
    var identifier: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .lichNhaHitTarget()
        .buttonStyle(.bordered)
        .tint(selected ? DesignTokens.son : DesignTokens.wood)
        .accessibilityAddTraits(selected ? .isSelected : [])
        .accessibilityIdentifier(identifier)
    }
}
