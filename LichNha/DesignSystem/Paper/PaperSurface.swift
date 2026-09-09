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
    var showsCurl: Bool = true
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
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: 4,
            bottomLeadingRadius: DesignTokens.radiusSheet,
            bottomTrailingRadius: DesignTokens.radiusSheet,
            topTrailingRadius: 4,
            style: .continuous
        )
        content()
            .padding(.horizontal, DesignTokens.spaceLG)
            .padding(.top, 10)
            .padding(.bottom, DesignTokens.spaceLG)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background {
                ZStack(alignment: .bottomTrailing) {
                    shape.fill(DesignTokens.paper)
                    if !solid {
                        PaperGrain()
                            .clipShape(shape)
                            .allowsHitTesting(false)
                            .accessibilityHidden(true)
                    }
                    if showsCurl && !solid {
                        PaperCornerCurl()
                            .fill(DesignTokens.paper)
                            .overlay {
                                PaperCornerCurl()
                                    .fill(DesignTokens.khanh.opacity(0.12))
                            }
                            .frame(width: 42, height: 38)
                            .overlay(alignment: .bottomTrailing) {
                                PaperCornerCurl()
                                    .stroke(DesignTokens.ink.opacity(0.10), lineWidth: 0.7)
                            }
                            .shadow(color: .black.opacity(0.12), radius: 3, y: 1)
                            .padding(.trailing, 1)
                            .padding(.bottom, 1)
                            .accessibilityHidden(true)
                    }
                }
                .shadow(color: .black.opacity(solid ? 0 : 0.18), radius: solid ? 0 : 8, y: solid ? 0 : 4)
            }
    }
}

struct PaperGrain: View {
    var body: some View {
        Canvas { context, size in
            let width = max(Int(size.width), 1)
            let height = max(Int(size.height), 1)
            for i in 0..<220 {
                let x = CGFloat((i * 47) % width)
                let y = CGFloat((i * 89) % height)
                let rect = CGRect(x: x, y: y, width: 1.1, height: 1.1)
                context.fill(Path(ellipseIn: rect), with: .color(.black.opacity(0.035)))
            }
        }
    }
}

struct WallPlasterView: View {
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast

    var body: some View {
        DesignTokens.wall
            .ignoresSafeArea()
            .overlay {
                if PaperLegibility.showsTexture(
                    reduceTransparency: reduceTransparency,
                    increasedContrast: colorSchemeContrast == .increased,
                    boldText: false
                ) {
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.35),
                            Color.clear,
                        ],
                        center: UnitPoint(x: 0.82, y: 0.08),
                        startRadius: 10,
                        endRadius: 320
                    )
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    PaperGrain()
                        .opacity(0.72)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }
            }
            .accessibilityHidden(true)
    }
}

struct PaperCornerCurl: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY + 4))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + 4, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY + 4),
            control: CGPoint(x: rect.midX + 4, y: rect.midY + 6)
        )
        path.closeSubpath()
        return path
    }
}
