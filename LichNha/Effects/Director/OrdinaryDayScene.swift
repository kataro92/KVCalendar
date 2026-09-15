import SwiftUI
import EffectCore

struct OrdinaryDayScene: View {
    var director: EffectDirector
    var seed: UInt64
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let staticScene = reduceMotion || director.resolved.quality == .resolvedStatic
        let gentleScene = director.resolved.quality == .resolvedGentle

        ZStack {
            MorningLightLayer(
                seed: seed,
                active: !staticScene && director.phase != .stopped,
                gentle: gentleScene
            )
            LeafShadowLayer(seed: seed, reduceMotion: staticScene)
            if !staticScene {
                FlutteringLeafLayer(
                    seed: seed,
                    active: director.phase != .stopped,
                    gentle: gentleScene,
                    intro: director.phase == .intro
                )
            }
        }
            .onAppear {
                if director.phase == .intro {
                    scheduleIntro()
                } else {
                    director.noteSettled()
                }
            }
            .onChange(of: director.phase) { _, phase in
                if phase == .intro { scheduleIntro() }
            }
    }

    private func scheduleIntro() {
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(900))
            director.noteIntroFinished()
            try? await Task.sleep(for: .milliseconds(300))
            director.noteSettled()
        }
    }
}

/// A sparse, deterministic paper-cut leaf pass kept at the edges of the scene.
/// It deliberately avoids the calendar's central reading area.
struct FlutteringLeafLayer: View {
    var seed: UInt64
    var active: Bool
    var gentle: Bool
    var intro: Bool

    private let leaves: [FlutteringLeaf] = [
        .init(start: CGPoint(x: 0.13, y: 0.17), end: CGPoint(x: 0.02, y: 0.27), duration: 6.8, phase: 0.3, angle: -0.35, scale: 0.9),
        .init(start: CGPoint(x: 0.88, y: 0.13), end: CGPoint(x: 0.98, y: 0.24), duration: 7.6, phase: 1.8, angle: 0.45, scale: 0.78),
        .init(start: CGPoint(x: 0.08, y: 0.86), end: CGPoint(x: 0.02, y: 0.73), duration: 8.8, phase: 3.0, angle: 0.25, scale: 0.72),
        .init(start: CGPoint(x: 0.91, y: 0.84), end: CGPoint(x: 0.99, y: 0.73), duration: 7.2, phase: 4.2, angle: -0.2, scale: 0.86)
    ]

    var body: some View {
        TimelineView(.animation(minimumInterval: active ? (gentle ? 1.0 / 12.0 : 1.0 / 30.0) : 1, paused: !active)) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate
                let seedOffset = CGFloat(seed % 11) * 0.002
                let visibleLeaves = intro ? leaves : Array(leaves.prefix(gentle ? 1 : 2))
                for (index, leaf) in visibleLeaves.enumerated() {
                    let restingGap = intro ? 2.5 : 9.0 + Double(index) * 2
                    let cycle = leaf.duration + restingGap
                    let elapsed = (now + leaf.phase * 10).truncatingRemainder(dividingBy: cycle)
                    guard elapsed <= leaf.duration else { continue }
                    let progress = active ? elapsed / leaf.duration : 0.35
                    let clamped = min(max(progress, 0), 1)
                    let eased = clamped * clamped * (3 - 2 * clamped)
                    let x = leaf.start.x + (leaf.end.x - leaf.start.x) * eased + seedOffset
                    let y = leaf.start.y + (leaf.end.y - leaf.start.y) * eased
                    let flutter = active ? sin(now * (1.25 + Double(index) * 0.12) + leaf.phase) : 0
                    let position = CGPoint(
                        x: size.width * x + CGFloat(flutter) * 5,
                        y: size.height * y + CGFloat(cos(now * 0.9 + leaf.phase)) * 3
                    )
                    drawLeaf(
                        in: &context,
                        at: position,
                        angle: leaf.angle + CGFloat(flutter) * 0.28,
                        scale: leaf.scale * (0.96 + CGFloat(sin(now * 0.7 + leaf.phase)) * 0.04),
                        color: index.isMultiple(of: 2) ? Color(red: 0.28, green: 0.39, blue: 0.31) : Color(red: 0.55, green: 0.28, blue: 0.22),
                        opacity: intro ? 0.42 : 0.24
                    )
                }
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private func drawLeaf(
        in context: inout GraphicsContext,
        at center: CGPoint,
        angle: CGFloat,
        scale: CGFloat,
        color: Color,
        opacity: Double
    ) {
        let length = 34 * scale
        let width = 15 * scale
        let direction = CGVector(dx: cos(angle), dy: sin(angle))
        let normal = CGVector(dx: -direction.dy, dy: direction.dx)
        let tip = CGPoint(x: center.x + direction.dx * length * 0.5, y: center.y + direction.dy * length * 0.5)
        let tail = CGPoint(x: center.x - direction.dx * length * 0.5, y: center.y - direction.dy * length * 0.5)
        let upper = CGPoint(x: center.x + normal.dx * width * 0.5, y: center.y + normal.dy * width * 0.5)
        let lower = CGPoint(x: center.x - normal.dx * width * 0.5, y: center.y - normal.dy * width * 0.5)

        var path = Path()
        path.move(to: tip)
        path.addQuadCurve(to: tail, control: upper)
        path.addQuadCurve(to: tip, control: lower)
        context.fill(path, with: .color(color.opacity(opacity)))

        var vein = Path()
        vein.move(to: tail)
        vein.addLine(to: tip)
        context.stroke(vein, with: .color(Color.white.opacity(0.30)), lineWidth: 0.8)
    }
}

/// A broad diagonal wash suggests morning light without drawing a literal window.
/// Its movement is deliberately slower than the leaves and freezes in poster mode.
struct MorningLightLayer: View {
    var seed: UInt64
    var active: Bool
    var gentle: Bool

    var body: some View {
        TimelineView(.animation(minimumInterval: active ? 1.0 / 12.0 : 1, paused: !active)) { timeline in
            GeometryReader { proxy in
                let time = active ? timeline.date.timeIntervalSinceReferenceDate : 0
                let phase = Double(seed % 29) * 0.17
                let drift = CGFloat(sin(time * (gentle ? 0.045 : 0.065) + phase)) * (gentle ? 3 : 5)
                let breathe = 0.86 + CGFloat(sin(time * 0.075 + phase) + 1) * 0.035

                ZStack {
                    RoundedRectangle(cornerRadius: 56, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0),
                                    DesignTokens.bronzeLight.opacity(0.13),
                                    Color.white.opacity(0.24),
                                    Color.white.opacity(0),
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: proxy.size.width * 0.42, height: proxy.size.height * 0.82)
                        .rotationEffect(.degrees(-12))
                        .scaleEffect(breathe)
                        .blur(radius: 22)
                        .offset(x: proxy.size.width * 0.34 + drift, y: -proxy.size.height * 0.10)

                    Ellipse()
                        .fill(DesignTokens.peach.opacity(0.18))
                        .frame(width: proxy.size.width * 0.54, height: proxy.size.height * 0.20)
                        .blur(radius: 28)
                        .offset(x: -proxy.size.width * 0.28 - drift * 0.4, y: proxy.size.height * 0.36)
                }
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}

private struct FlutteringLeaf {
    var start: CGPoint
    var end: CGPoint
    var duration: TimeInterval
    var phase: TimeInterval
    var angle: CGFloat
    var scale: CGFloat
}

struct LeafShadowLayer: View {
    var seed: UInt64
    var reduceMotion: Bool

    var body: some View {
        TimelineView(.animation(minimumInterval: reduceMotion ? 12 : 1.0 / 8.0, paused: reduceMotion)) { timeline in
            Canvas { context, size in
                var rng = SeededRandom(seed: seed ^ 0xA5A5)
                let time = reduceMotion ? 0.0 : timeline.date.timeIntervalSinceReferenceDate
                let drift = CGFloat(sin(time * 0.09)) * 12
                drawCluster(
                    &rng,
                    context: context,
                    size: size,
                    time: time,
                    drift: drift,
                    xRange: 0.58...0.98,
                    yRange: 0.06...0.19,
                    count: 8
                )
                drawCluster(
                    &rng,
                    context: context,
                    size: size,
                    time: time,
                    drift: -drift * 0.55,
                    xRange: 0.0...0.24,
                    yRange: 0.76...0.97,
                    count: 5
                )
            }
        }
        .blur(radius: 5.5)
        .opacity(0.88)
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private func drawCluster(
        _ rng: inout SeededRandom,
        context: GraphicsContext,
        size: CGSize,
        time: TimeInterval,
        drift: CGFloat,
        xRange: ClosedRange<Double>,
        yRange: ClosedRange<Double>,
        count: Int
    ) {
        for index in 0..<count {
            let originX = size.width * CGFloat(xRange.lowerBound + rng.next() * (xRange.upperBound - xRange.lowerBound))
            let originY = size.height * CGFloat(yRange.lowerBound + rng.next() * (yRange.upperBound - yRange.lowerBound))
            let width = 28 + CGFloat(rng.next() * 42)
            let height = 12 + CGFloat(rng.next() * 18)
            let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
            var leafContext = context
            leafContext.translateBy(
                x: originX + drift * (index.isMultiple(of: 2) ? 1 : -0.55),
                y: originY + CGFloat(sin(time * 0.07 + Double(index))) * 3
            )
            leafContext.rotate(by: .degrees(-38 + rng.next() * 70))
            var leaf = Path()
            leaf.addEllipse(in: rect)
            leafContext.fill(
                leaf,
                with: .color(Color.black.opacity(0.14 + rng.next() * 0.10))
            )
        }
    }
}
