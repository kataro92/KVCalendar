import SwiftUI

enum PaperLegibility {
    static func showsTexture(
        reduceTransparency: Bool,
        increasedContrast: Bool,
        boldText: Bool
    ) -> Bool {
        !reduceTransparency && !increasedContrast && !boldText
    }
}

struct PaperSurface<Content: View>: View {
    @ViewBuilder var content: () -> Content
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast
    @Environment(\.legibilityWeight) private var legibilityWeight

    var body: some View {
        let solid = !PaperLegibility.showsTexture(
            reduceTransparency: reduceTransparency,
            increasedContrast: colorSchemeContrast == .increased,
            boldText: legibilityWeight == .bold
        )
        content()
            .padding(DesignTokens.spaceLG)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: DesignTokens.radiusSheet, style: .continuous)
                        .fill(DesignTokens.paper)
                    if !solid {
                        Canvas { context, size in
                            let width = max(Int(size.width), 1)
                            let height = max(Int(size.height), 1)
                            for i in 0..<90 {
                                let x = CGFloat((i * 47) % width)
                                let y = CGFloat((i * 89) % height)
                                let rect = CGRect(x: x, y: y, width: 1.2, height: 1.2)
                                context.fill(Path(ellipseIn: rect), with: .color(.black.opacity(0.04)))
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.radiusSheet, style: .continuous))
                        .allowsHitTesting(false)
                        .accessibilityHidden(true)
                    }
                }
                .shadow(color: .black.opacity(solid ? 0 : 0.12), radius: solid ? 0 : 8, y: solid ? 0 : 4)
            }
    }
}
