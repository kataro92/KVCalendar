import SwiftUI

enum ParticleKind: String, Sendable {
    case firework
    case petal
    case rain
    case dust
}

struct ParticleLibrary: View {
    var kind: ParticleKind
    var seed: UInt64
    var active: Bool
    var dimFlashingLights: Bool

    var body: some View {
        TimelineView(.animation(minimumInterval: active ? 1.0 / 30.0 : 1, paused: !active)) { timeline in
            Canvas { context, size in
                var rng = SeededRandom(seed: seed)
                switch kind {
                case .firework:
                    drawFireworks(&rng, context: context, size: size, time: timeline.date.timeIntervalSinceReferenceDate, dim: dimFlashingLights)
                case .petal:
                    drawPetals(&rng, context: context, size: size, time: timeline.date.timeIntervalSinceReferenceDate)
                case .rain:
                    drawRain(&rng, context: context, size: size, time: timeline.date.timeIntervalSinceReferenceDate)
                case .dust:
                    drawDust(&rng, context: context, size: size)
                }
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private func drawFireworks(
        _ rng: inout SeededRandom,
        context: GraphicsContext,
        size: CGSize,
        time: TimeInterval,
        dim: Bool
    ) {
        let bursts = dim ? 2 : 3
        for index in 0..<bursts {
            let origin = CGPoint(
                x: size.width * CGFloat(0.08 + rng.next() * 0.84),
                y: size.height * CGFloat(0.07 + rng.next() * 0.62)
            )
            let hueShift = index
            let age = (time + Double(index) * 0.62).truncatingRemainder(dividingBy: 3.4)
            let progress = min(max(age / 1.65, 0), 1)
            let envelope = CGFloat(sin(progress * .pi))
            let radius = CGFloat(dim ? 16.0 : 24.0 + rng.next() * 18.0) * CGFloat(0.45 + progress * 0.55)
            let color = hueShift.isMultiple(of: 2)
                ? DesignTokens.son.opacity((dim ? 0.24 : 0.46) * envelope)
                : DesignTokens.bronzeLight.opacity((dim ? 0.22 : 0.55) * envelope)
            let rays = dim ? 7 : 11
            let haloRect = CGRect(
                x: origin.x - radius * 0.54,
                y: origin.y - radius * 0.54,
                width: radius * 1.08,
                height: radius * 1.08
            )
            context.stroke(
                Path(ellipseIn: haloRect),
                with: .color(color.opacity(dim ? 0.10 : 0.18)),
                lineWidth: dim ? 0.5 : 0.8
            )
            for ray in 0..<rays {
                let angle = CGFloat(ray) * (.pi * 2 / CGFloat(rays)) + CGFloat(rng.next() * 0.08)
                let inner = radius * 0.34
                let outer = radius * (0.78 + rng.next() * 0.22)
                let tail = CGPoint(x: origin.x + cos(angle) * inner, y: origin.y + sin(angle) * inner)
                let tip = CGPoint(x: origin.x + cos(angle) * outer, y: origin.y + sin(angle) * outer)
                var stroke = Path()
                stroke.move(to: tail)
                stroke.addQuadCurve(
                    to: tip,
                    control: CGPoint(
                        x: (tail.x + tip.x) * 0.5 - sin(angle) * 2.5,
                        y: (tail.y + tip.y) * 0.5 + cos(angle) * 2.5
                    )
                )
                context.stroke(stroke, with: .color(color), lineWidth: dim ? 0.9 : 1.5)
                if !dim && ray.isMultiple(of: 2) {
                    let sparkSize: CGFloat = 2.2
                    context.fill(
                        Path(ellipseIn: CGRect(
                            x: tip.x - sparkSize / 2,
                            y: tip.y - sparkSize / 2,
                            width: sparkSize,
                            height: sparkSize
                        )),
                        with: .color(color.opacity(0.88))
                    )
                }
            }
            context.fill(
                Path(ellipseIn: CGRect(x: origin.x - 2, y: origin.y - 2, width: 4, height: 4)),
                with: .color(color)
            )
        }
    }

    private func drawPetals(_ rng: inout SeededRandom, context: GraphicsContext, size: CGSize, time: TimeInterval) {
        let count = 6
        for index in 0..<count {
            let startX = size.width * CGFloat(0.08 + rng.next() * 0.84)
            let drift = CGFloat(sin(time * 0.34 + Double(index) * 1.7)) * 13
            let y = size.height * 0.11 + CGFloat(index) * 10 + CGFloat(sin(time * 0.75 + Double(index))) * 5
            let angle = CGFloat(sin(time * 0.55 + Double(index) * 1.3)) * 0.45
            let scale = 0.82 + CGFloat((index % 3)) * 0.08
            drawPetal(
                context: context,
                center: CGPoint(x: startX + drift, y: y),
                angle: angle,
                scale: scale,
                color: index.isMultiple(of: 2)
                    ? Color(red: 0.93, green: 0.72, blue: 0.74)
                    : Color(red: 0.88, green: 0.62, blue: 0.60)
            )
        }
    }

    private func drawPetal(context: GraphicsContext, center: CGPoint, angle: CGFloat, scale: CGFloat, color: Color) {
        let length = 13 * scale
        let width = 7 * scale
        let direction = CGVector(dx: cos(angle), dy: sin(angle))
        let normal = CGVector(dx: -direction.dy, dy: direction.dx)
        let tip = CGPoint(x: center.x + direction.dx * length * 0.5, y: center.y + direction.dy * length * 0.5)
        let tail = CGPoint(x: center.x - direction.dx * length * 0.5, y: center.y - direction.dy * length * 0.5)
        let upper = CGPoint(x: center.x + normal.dx * width * 0.5, y: center.y + normal.dy * width * 0.5)
        let lower = CGPoint(x: center.x - normal.dx * width * 0.5, y: center.y - normal.dy * width * 0.5)

        var shape = Path()
        shape.move(to: tip)
        shape.addQuadCurve(to: tail, control: upper)
        shape.addQuadCurve(to: tip, control: lower)
        context.fill(shape, with: .color(color.opacity(0.62)))

        var crease = Path()
        crease.move(to: tail)
        crease.addLine(to: tip)
        context.stroke(crease, with: .color(Color.white.opacity(0.25)), lineWidth: 0.6)
    }

    private func drawRain(_ rng: inout SeededRandom, context: GraphicsContext, size: CGSize, time: TimeInterval) {
        for index in 0..<12 {
            let x = size.width * CGFloat(rng.next())
            let y = (size.height * CGFloat((time * 0.15 + rng.next()).truncatingRemainder(dividingBy: 1)))
            var drop = Path()
            drop.move(to: CGPoint(x: x, y: y))
            drop.addLine(to: CGPoint(x: x + 2, y: y + 10))
            context.stroke(drop, with: .color(Color(red: 0.55, green: 0.65, blue: 0.72).opacity(0.25)), lineWidth: 1)
            _ = index
        }
    }

    private func drawDust(_ rng: inout SeededRandom, context: GraphicsContext, size: CGSize) {
        for _ in 0..<8 {
            let x = size.width * CGFloat(rng.next())
            let y = size.height * CGFloat(0.05 + rng.next() * 0.25)
            let rect = CGRect(x: x, y: y, width: 2, height: 2)
            context.fill(Path(ellipseIn: rect), with: .color(Color.white.opacity(0.18)))
        }
    }
}

struct SeededRandom {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed == 0 ? 0x9E37_79B9_7F4A_7C15 : seed
    }

    mutating func next() -> Double {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        z = z ^ (z >> 31)
        return Double(z % 10_000) / 10_000
    }
}
