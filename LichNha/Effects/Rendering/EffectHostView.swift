import SwiftUI
import EffectCore
import PersonalCore

struct EffectHostView: View {
    var director: EffectDirector
    var daySeed: UInt64
    var region: InspirationRegion = .neutral

    var body: some View {
        GeometryReader { proxy in
            let safe = contentSafeRect(in: proxy.size)
            Group {
                if director.resolved.quality == .resolvedStatic {
                    PosterSceneView(posterID: director.resolved.posterID)
                } else {
                    scene
                }
            }
            .mask(particleMask(size: proxy.size, safe: safe))
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    @ViewBuilder
    private var scene: some View {
        switch director.resolved.heroCueID {
        case "cue-quoc-khanh":
            NationalDayScene(director: director)
        case "cue-lap-xuan":
            BeginningOfSpringScene(director: director, region: region)
        case "cue-ordinary":
            OrdinaryDayScene(director: director, seed: daySeed)
        default:
            EmptyView()
        }
    }

    private func contentSafeRect(in size: CGSize) -> CGRect {
        CGRect(
            x: size.width * 0.18,
            y: size.height * 0.28,
            width: size.width * 0.64,
            height: size.height * 0.52
        )
    }

    private func particleMask(size: CGSize, safe: CGRect) -> some View {
        Canvas { context, canvasSize in
            context.fill(Path(CGRect(origin: .zero, size: canvasSize)), with: .color(.white))
            context.blendMode = .destinationOut
            context.fill(Path(roundedRect: safe, cornerRadius: 12), with: .color(.white))
        }
    }
}
