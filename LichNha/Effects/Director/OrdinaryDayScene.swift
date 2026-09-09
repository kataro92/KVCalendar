import SwiftUI
import EffectCore

struct OrdinaryDayScene: View {
    var director: EffectDirector
    var seed: UInt64

    var body: some View {
        Group {
            if seed % 2 == 0 {
                WindowWash()
                    .stroke(Color.white.opacity(0.16), lineWidth: 1)
                    .background(WindowWash().fill(Color.white.opacity(0.06)))
                    .frame(width: 52, height: 34)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.trailing, 36)
                    .padding(.top, 12)
            } else {
                SpringBranchSilhouette()
                    .stroke(DesignTokens.wood.opacity(0.28), lineWidth: 1.5)
                    .frame(width: 48, height: 56)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading, 20)
                    .padding(.top, 10)
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
