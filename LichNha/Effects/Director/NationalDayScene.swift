import SwiftUI
import EffectCore

struct NationalDayScene: View {
    var director: EffectDirector
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.lichNhaDimFlashingLights) private var dimFlashingLights

    var body: some View {
        ZStack(alignment: .topTrailing) {
            PosterSceneView(posterID: "poster-quoc-khanh")
            if director.particlesActive {
                ParticleLibrary(
                    kind: .firework,
                    seed: director.seed,
                    active: true,
                    dimFlashingLights: dimFlashingLights
                )
            }
        }
        .onAppear {
            if director.phase == .intro {
                scheduleIntro()
            }
        }
        .onChange(of: director.phase) { _, phase in
            if phase == .intro {
                scheduleIntro()
            }
        }
        .accessibilityHidden(reduceMotion)
    }

    private func scheduleIntro() {
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(2800))
            director.noteIntroFinished()
            try? await Task.sleep(for: .milliseconds(600))
            director.noteSettled()
        }
    }
}
