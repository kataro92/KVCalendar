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
            topLeadingRadius: 2,
            bottomLeadingRadius: DesignTokens.radiusSheet,
            bottomTrailingRadius: DesignTokens.radiusSheet,
            topTrailingRadius: 2,
            style: .continuous
        )
        content()
            .padding(.horizontal, DesignTokens.spaceLG)
            .padding(.top, 14)
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
                            .frame(width: 34, height: 30)
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
                .shadow(color: .black.opacity(solid ? 0 : 0.20), radius: solid ? 0 : 10, y: solid ? 0 : 6)
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
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        DesignTokens.wall
            .ignoresSafeArea()
            .overlay {
                if PaperLegibility.showsTexture(
                    reduceTransparency: reduceTransparency,
                    increasedContrast: colorSchemeContrast == .increased,
                    boldText: false
                ) {
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.26),
                            Color.clear,
                            DesignTokens.wood.opacity(0.08),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.46),
                            Color.clear,
                        ],
                        center: UnitPoint(x: 0.78, y: 0.12),
                        startRadius: 10,
                        endRadius: 290
                    )
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                    WallFiberLines()
                        .opacity(0.46)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                    PaperGrain()
                        .opacity(0.50)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                    if !reduceMotion {
                        AmbientDustLayer()
                            .ignoresSafeArea()
                            .allowsHitTesting(false)
                    }
                }
            }
            .accessibilityHidden(true)
    }
}

/// Very low-contrast dust motes make the plaster feel like a material surface.
/// They live behind the calendar and never compete with the primary scene effect.
private struct AmbientDustLayer: View {
    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 12.0)) { timeline in
            Canvas { context, size in
                let time = timeline.date.timeIntervalSinceReferenceDate
                let motes: [(x: CGFloat, y: CGFloat, radius: CGFloat, phase: Double)] = [
                    (0.08, 0.18, 1.4, 0.2), (0.19, 0.72, 1.1, 1.7),
                    (0.78, 0.22, 1.2, 2.4), (0.91, 0.64, 1.5, 3.1),
                    (0.34, 0.88, 0.9, 4.0), (0.66, 0.12, 1.0, 5.1)
                ]
                for mote in motes {
                    let x = size.width * mote.x + CGFloat(sin(time * 0.06 + mote.phase)) * 4
                    let y = size.height * mote.y + CGFloat(cos(time * 0.045 + mote.phase)) * 5
                    let opacity = 0.07 + CGFloat((sin(time * 0.18 + mote.phase) + 1) * 0.025)
                    let rect = CGRect(x: x - mote.radius, y: y - mote.radius, width: mote.radius * 2, height: mote.radius * 2)
                    context.fill(Path(ellipseIn: rect), with: .color(Color.white.opacity(opacity)))
                }
            }
        }
        .accessibilityHidden(true)
    }
}

private struct WallFiberLines: View {
    var body: some View {
        Canvas { context, size in
            for index in 0..<18 {
                let y = CGFloat(index) * max(size.height / 17, 1)
                var line = Path()
                line.move(to: CGPoint(x: 0, y: y))
                line.addQuadCurve(
                    to: CGPoint(x: size.width, y: y + 1.5),
                    control: CGPoint(x: size.width * 0.55, y: y - 2)
                )
                context.stroke(line, with: .color(DesignTokens.wood.opacity(0.07)), lineWidth: 0.55)
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
