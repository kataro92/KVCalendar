import SwiftUI

struct PaperStackView<Content: View>: View {
    var peeled: Bool
    /// R0: thick classic bloc — 10–12 staggered sheets.
    private let layerCount = 11
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Soft drop under the whole object
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.black.opacity(0.16))
                .blur(radius: 10)
                .offset(y: 14)
                .padding(.horizontal, 4)
                .accessibilityHidden(true)

            // Paper stack edges (behind face), stronger stagger
            ForEach(0..<layerCount, id: \.self) { index in
                let depth = CGFloat(layerCount - index)
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
                    .stroke(DesignTokens.wood.opacity(0.12), lineWidth: 0.55)
                }
                // y ~3–4pt per layer; slight left/right weave
                .offset(
                    x: index.isMultiple(of: 2) ? -depth * 0.85 : depth * 0.55,
                    y: depth * 3.5
                )
                .padding(.horizontal, depth * 0.35)
                .accessibilityHidden(true)
            }

            // Face sheet: AO gap + lift + binding rivets
            ZStack(alignment: .top) {
                // AO / dark cleft between face and stack
                UnevenRoundedRectangle(
                    topLeadingRadius: 2,
                    bottomLeadingRadius: DesignTokens.radiusSheet,
                    bottomTrailingRadius: DesignTokens.radiusSheet,
                    topTrailingRadius: 2,
                    style: .continuous
                )
                .fill(Color.black.opacity(0.22))
                .blur(radius: 2.5)
                .offset(y: 5)
                .padding(.horizontal, 3)
                .accessibilityHidden(true)

                content()
                    .offset(y: peeled ? 6 : -2)
                    .overlay(alignment: .top) {
                        HStack {
                            BrassRivet()
                            Spacer()
                            BrassRivet()
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                    }
            }
            .zIndex(2)
        }
        .padding(.horizontal, 5)
        .padding(.bottom, 18)
        .compositingGroup()
        .shadow(color: .black.opacity(0.18), radius: 20, y: 14)
    }
}
