import SwiftUI
import EffectCore

struct NationalDayScene: View {
    var director: EffectDirector
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if director.particlesActive {
                ParticleLibrary(
                    kind: .firework,
                    seed: director.seed,
                    active: true,
                    dimFlashingLights: false
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
