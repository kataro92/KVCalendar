import SwiftUI
import EffectCore

struct PosterSceneView: View {
    var posterID: String?

    var body: some View {
        switch posterID {
        case "poster-quoc-khanh":
            NationalDayPoster()
        case "poster-lap-xuan":
            SpringBranchSilhouette()
                .stroke(DesignTokens.wood.opacity(0.55), lineWidth: 2)
                .frame(width: 70, height: 90)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, 18)
                .padding(.top, 8)
        case "poster-ordinary":
            ZStack {
                MorningLightLayer(seed: 17, active: false, gentle: true)
                LeafShadowLayer(seed: 17, reduceMotion: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        default:
            if let termIndex = solarTermIndex {
                SolarTermPoster(termIndex: termIndex)
            } else {
                Color.clear
            }
        }
    }

    private var solarTermIndex: Int? {
        guard let posterID, posterID.hasPrefix("poster-term-") else { return nil }
        return Int(posterID.dropFirst("poster-term-".count))
    }
}

private struct SolarTermPoster: View {
    var termIndex: Int

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RadialGradient(
                    colors: [palette.wash.opacity(0.44), Color.clear],
                    center: termIndex == 11 ? UnitPoint(x: 0.80, y: 0.16) : UnitPoint(x: 0.18, y: 0.20),
                    startRadius: 8,
                    endRadius: proxy.size.width * 0.72
                )
                MorningLightLayer(seed: UInt64(termIndex + 31), active: false, gentle: true)
                    .opacity(palette.lightOpacity)
                SeasonalEdgeArtwork(
                    termIndex: termIndex,
                    primary: palette.primary,
                    secondary: palette.secondary
                )
            }
        }
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }

    private var palette: SolarTermPalette {
        switch termIndex {
        case 0...3:
            SolarTermPalette(primary: DesignTokens.jade, secondary: DesignTokens.peach, wash: DesignTokens.sky, lightOpacity: 0.65)
        case 4...7:
            SolarTermPalette(primary: DesignTokens.sky, secondary: DesignTokens.jade, wash: DesignTokens.bronzeLight, lightOpacity: 0.82)
        case 8...11:
            SolarTermPalette(primary: DesignTokens.jade, secondary: DesignTokens.bronzeLight, wash: DesignTokens.sky, lightOpacity: 0.58)
        case 12...15:
            SolarTermPalette(primary: DesignTokens.bronzeLight, secondary: DesignTokens.son, wash: DesignTokens.peach, lightOpacity: 0.72)
        case 16...19:
            SolarTermPalette(primary: DesignTokens.sky, secondary: DesignTokens.inkSecondary, wash: DesignTokens.jade, lightOpacity: 0.38)
        default:
            SolarTermPalette(primary: DesignTokens.peach, secondary: DesignTokens.jade, wash: DesignTokens.peach, lightOpacity: 0.60)
        }
    }
}

private struct SolarTermPalette {
    var primary: Color
    var secondary: Color
    var wash: Color
    var lightOpacity: Double
}

private struct SeasonalEdgeArtwork: View {
    var termIndex: Int
    var primary: Color
    var secondary: Color

    var body: some View {
        Canvas { context, size in
            var rng = SeededRandom(seed: UInt64(termIndex + 1) * 0x9E37)
            let dewScene = (8...11).contains(termIndex) || (16...19).contains(termIndex)
            for index in 0..<14 {
                let onLeft = index.isMultiple(of: 2)
                let xBand = 0.02 + rng.next() * 0.14
                let x = size.width * CGFloat(onLeft ? xBand : 1 - xBand)
                let y = size.height * CGFloat(0.08 + rng.next() * 0.82)
                let color = index.isMultiple(of: 3) ? primary : secondary

                if dewScene {
                    let diameter = CGFloat(3.5 + rng.next() * 5.5)
                    let drop = CGRect(
                        x: x - diameter / 2,
                        y: y - diameter / 2,
                        width: diameter,
                        height: diameter
                    )
                    context.fill(Path(ellipseIn: drop), with: .color(color.opacity(0.20)))
                    context.stroke(Path(ellipseIn: drop), with: .color(Color.white.opacity(0.48)), lineWidth: 0.7)
                } else {
                    drawLeaf(
                        context: &context,
                        center: CGPoint(x: x, y: y),
                        angle: CGFloat(-0.8 + rng.next() * 1.6),
                        length: CGFloat(17 + rng.next() * 18),
                        color: color.opacity(0.24)
                    )
                }
            }

            if dewScene {
                drawDewStems(context: &context, size: size)
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private func drawLeaf(
        context: inout GraphicsContext,
        center: CGPoint,
        angle: CGFloat,
        length: CGFloat,
        color: Color
    ) {
        let direction = CGVector(dx: cos(angle), dy: sin(angle))
        let normal = CGVector(dx: -direction.dy, dy: direction.dx)
        let tip = CGPoint(x: center.x + direction.dx * length / 2, y: center.y + direction.dy * length / 2)
        let tail = CGPoint(x: center.x - direction.dx * length / 2, y: center.y - direction.dy * length / 2)
        let width = length * 0.36
        let upper = CGPoint(x: center.x + normal.dx * width, y: center.y + normal.dy * width)
        let lower = CGPoint(x: center.x - normal.dx * width, y: center.y - normal.dy * width)
        var leaf = Path()
        leaf.move(to: tip)
        leaf.addQuadCurve(to: tail, control: upper)
        leaf.addQuadCurve(to: tip, control: lower)
        context.fill(leaf, with: .color(color))
    }

    private func drawDewStems(context: inout GraphicsContext, size: CGSize) {
        for side in [CGFloat(0.0), 1.0] {
            let anchorX = side == 0 ? size.width * 0.08 : size.width * 0.92
            for index in 0..<3 {
                var stem = Path()
                let baseY = size.height * (0.70 + CGFloat(index) * 0.055)
                stem.move(to: CGPoint(x: anchorX, y: baseY))
                stem.addQuadCurve(
                    to: CGPoint(x: anchorX + (side == 0 ? 18 : -18), y: baseY - 48),
                    control: CGPoint(x: anchorX + (side == 0 ? -4 : 4), y: baseY - 24)
                )
                context.stroke(stem, with: .color(primary.opacity(0.18)), lineWidth: 1.1)
            }
        }
    }
}

private struct NationalDayPoster: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RadialGradient(
                    colors: [DesignTokens.peach.opacity(0.92), DesignTokens.son.opacity(0.18), Color.clear],
                    center: UnitPoint(x: 0.5, y: 0.24),
                    startRadius: 8,
                    endRadius: proxy.size.width * 0.78
                )
                NationalCelebrationLines()
                    .stroke(
                        LinearGradient(
                            colors: [DesignTokens.bronzeLight.opacity(0.92), DesignTokens.son.opacity(0.64)],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        style: StrokeStyle(lineWidth: 1.55, lineCap: .round)
                    )
                    .padding(.horizontal, 8)
                    .padding(.top, 18)
                NationalCelebrationSparks()
                    .fill(DesignTokens.bronzeLight.opacity(0.72))
                    .padding(.horizontal, 4)
                    .padding(.top, 12)
            }
        }
        .ignoresSafeArea()
    }
}

private struct NationalCelebrationLines: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bursts = [
            (CGPoint(x: rect.width * 0.10, y: rect.height * 0.17), CGFloat(47)),
            (CGPoint(x: rect.width * 0.90, y: rect.height * 0.14), CGFloat(54)),
            (CGPoint(x: rect.width * 0.01, y: rect.height * 0.55), CGFloat(58)),
            (CGPoint(x: rect.width * 0.99, y: rect.height * 0.52), CGFloat(61)),
        ]
        for (center, radius) in bursts {
            for ray in 0..<10 {
                let angle = CGFloat(ray) * .pi / 5
                let inner = radius * 0.48
                path.move(to: CGPoint(x: center.x + cos(angle) * inner, y: center.y + sin(angle) * inner))
                path.addLine(to: CGPoint(x: center.x + cos(angle) * radius, y: center.y + sin(angle) * radius))
            }
        }
        return path
    }
}

private struct NationalCelebrationSparks: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let points: [CGPoint] = [
            CGPoint(x: rect.width * 0.19, y: rect.height * 0.09),
            CGPoint(x: rect.width * 0.81, y: rect.height * 0.08),
            CGPoint(x: rect.width * 0.05, y: rect.height * 0.31),
            CGPoint(x: rect.width * 0.95, y: rect.height * 0.34),
            CGPoint(x: rect.width * 0.07, y: rect.height * 0.70),
            CGPoint(x: rect.width * 0.93, y: rect.height * 0.72),
        ]
        for (index, point) in points.enumerated() {
            let diameter: CGFloat = index.isMultiple(of: 2) ? 4 : 2.5
            path.addEllipse(in: CGRect(
                x: point.x - diameter / 2,
                y: point.y - diameter / 2,
                width: diameter,
                height: diameter
            ))
        }
        return path
    }
}

struct SpringBranchSilhouette: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 4, y: rect.maxY - 6))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.midY),
            control: CGPoint(x: rect.minX + 8, y: rect.midY + 10)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - 8, y: rect.minY + 10),
            control: CGPoint(x: rect.midX + 12, y: rect.minY + 18)
        )
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX + 16, y: rect.midY - 22),
            control: CGPoint(x: rect.midX + 4, y: rect.midY - 8)
        )
        return path
    }
}

struct WindowWash: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path(roundedRect: rect, cornerRadius: 3)
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
