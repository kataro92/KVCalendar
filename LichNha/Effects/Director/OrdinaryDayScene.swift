import SwiftUI
import EffectCore

struct OrdinaryDayScene: View {
    var director: EffectDirector
    var seed: UInt64
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        LeafShadowLayer(seed: seed, reduceMotion: reduceMotion || director.resolved.quality == .resolvedStatic)
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
        .blur(radius: 4.5)
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
