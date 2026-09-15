import SwiftUI
import EffectCore
import PersonalCore

struct EffectHostView: View {
    var director: EffectDirector
    var daySeed: UInt64
    var region: InspirationRegion = .neutral

    var body: some View {
        Group {
            if director.resolved.quality == .resolvedStatic {
                PosterSceneView(posterID: director.resolved.posterID)
            } else {
                scene
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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

}
