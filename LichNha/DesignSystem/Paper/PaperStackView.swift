import SwiftUI

struct PaperStackView<Content: View>: View {
    var peeled: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack(alignment: .bottom) {
            ForEach(0..<5, id: \.self) { index in
                RoundedRectangle(cornerRadius: DesignTokens.radiusSheet, style: .continuous)
                    .fill(DesignTokens.paper.opacity(0.9))
                    .offset(y: CGFloat(4 - index) * 3)
                    .padding(.horizontal, CGFloat(4 - index) * 2)
                    .accessibilityHidden(true)
            }
            content()
                .offset(y: peeled ? 6 : 0)
        }
    }
}
