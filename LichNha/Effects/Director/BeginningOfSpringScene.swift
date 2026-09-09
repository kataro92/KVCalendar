import SwiftUI
import EffectCore
import PersonalCore

struct BeginningOfSpringScene: View {
    var director: EffectDirector
    var region: InspirationRegion = .neutral

    var body: some View {
        ZStack(alignment: .topLeading) {
            SpringBranchSilhouette()
                .stroke(branchColor, style: StrokeStyle(lineWidth: region == .central ? 1.2 : 2, lineCap: .round))
                .frame(width: 78, height: 96)
                .padding(.leading, 16)
                .padding(.top, 6)
            if director.particlesActive {
                ParticleLibrary(
                    kind: .petal,
                    seed: director.seed,
                    active: true,
                    dimFlashingLights: false
                )
            } else {
                petalRest
            }
        }
        .onAppear {
            if director.phase == .intro {
                scheduleIntro()
            }
        }
        .onChange(of: director.phase) { _, phase in
            if phase == .intro { scheduleIntro() }
        }
    }

    private var branchColor: Color {
        DesignTokens.wood.opacity(region == .neutral ? 0.55 : 0.7)
    }

    private var petalRest: some View {
        HStack(spacing: 6) {
            Capsule().fill(petalColor.opacity(0.7)).frame(width: 8, height: 4)
            Capsule().fill(petalColor.opacity(0.5)).frame(width: 8, height: 4)
        }
        .padding(.leading, 40)
        .padding(.top, 28)
    }

    private var petalColor: Color {
        switch region {
        case .north: DesignTokens.peach
        case .south: Color(red: 0.90, green: 0.78, blue: 0.42)
        case .central: DesignTokens.jade
        case .neutral: DesignTokens.inkSecondary
        }
    }

    private func scheduleIntro() {
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(1800))
            director.noteIntroFinished()
            try? await Task.sleep(for: .milliseconds(400))
            director.noteSettled()
        }
    }
}
