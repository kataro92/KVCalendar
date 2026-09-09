import SwiftUI

struct PaperStackView<Content: View>: View {
    var peeled: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ForEach(0..<7, id: \.self) { index in
                let depth = CGFloat(7 - index)
                UnevenRoundedRectangle(
                    topLeadingRadius: 4,
                    bottomLeadingRadius: DesignTokens.radiusSheet,
                    bottomTrailingRadius: DesignTokens.radiusSheet,
                    topTrailingRadius: 4,
                    style: .continuous
                )
                .fill(DesignTokens.paper.opacity(0.97 - Double(index) * 0.03))
                .overlay {
                    UnevenRoundedRectangle(
                        topLeadingRadius: 4,
                        bottomLeadingRadius: DesignTokens.radiusSheet,
                        bottomTrailingRadius: DesignTokens.radiusSheet,
                        topTrailingRadius: 4,
                        style: .continuous
                    )
                    .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
                }
                .offset(x: -depth * 2.1, y: depth * 2.6)
                .padding(.trailing, depth * 1.1)
                .accessibilityHidden(true)
            }
            content()
                .offset(y: peeled ? 6 : 0)
        }
        .padding(.leading, 16)
        .padding(.bottom, 18)
        .compositingGroup()
        .shadow(color: .black.opacity(0.16), radius: 16, y: 10)
    }
}
