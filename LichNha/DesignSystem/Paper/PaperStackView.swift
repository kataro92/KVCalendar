import SwiftUI

struct PaperStackView<Content: View>: View {
    var peeled: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.black.opacity(0.10))
                .blur(radius: 6)
                .offset(y: 10)
                .padding(.horizontal, 5)
                .accessibilityHidden(true)
            ForEach(0..<5, id: \.self) { index in
                let depth = CGFloat(5 - index)
                UnevenRoundedRectangle(
                    topLeadingRadius: 2,
                    bottomLeadingRadius: DesignTokens.radiusSheet,
                    bottomTrailingRadius: DesignTokens.radiusSheet,
                    topTrailingRadius: 2,
                    style: .continuous
                )
                .fill(index.isMultiple(of: 2) ? DesignTokens.paper : DesignTokens.chipFill)
                .overlay {
                    UnevenRoundedRectangle(
                        topLeadingRadius: 2,
                        bottomLeadingRadius: DesignTokens.radiusSheet,
                        bottomTrailingRadius: DesignTokens.radiusSheet,
                        topTrailingRadius: 2,
                        style: .continuous
                    )
                    .stroke(DesignTokens.wood.opacity(0.10), lineWidth: 0.55)
                }
                .offset(x: index.isMultiple(of: 2) ? -depth * 0.65 : depth * 0.35, y: depth * 2.2)
                .padding(.horizontal, depth * 0.45)
                .accessibilityHidden(true)
            }
            content()
                .offset(y: peeled ? 6 : 0)
        }
        .padding(.horizontal, 5)
        .padding(.bottom, 14)
        .compositingGroup()
        .shadow(color: .black.opacity(0.14), radius: 18, y: 12)
    }
}
