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
        let bursts = 3
        for index in 0..<bursts {
            let origin = CGPoint(
                x: size.width * CGFloat(0.18 + rng.next() * 0.64),
                y: size.height * CGFloat(0.08 + rng.next() * 0.18)
            )
            let hueShift = index
            let radius = dim ? 10.0 : 8.0 + 6.0 * abs(sin(time * 0.7 + Double(index)))
            let color = hueShift == 0 ? Color(red: 0.85, green: 0.22, blue: 0.24).opacity(0.35)
                : Color(red: 0.95, green: 0.78, blue: 0.28).opacity(0.32)
            let rect = CGRect(x: origin.x - radius, y: origin.y - radius, width: radius * 2, height: radius * 2)
            context.fill(Path(ellipseIn: rect), with: .color(color))
        }
    }

    private func drawPetals(_ rng: inout SeededRandom, context: GraphicsContext, size: CGSize, time: TimeInterval) {
        let count = 6
        for index in 0..<count {
            let startX = size.width * CGFloat(0.08 + rng.next() * 0.84)
            let drift = CGFloat(sin(time * 0.4 + Double(index))) * 8
            let y = size.height * 0.12 + CGFloat(index) * 9 + CGFloat(sin(time + Double(index))) * 4
            var petal = Path()
            petal.addEllipse(in: CGRect(x: startX + drift, y: y, width: 9, height: 5))
            context.fill(petal, with: .color(Color(red: 0.93, green: 0.72, blue: 0.74).opacity(0.55)))
        }
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
