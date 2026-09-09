import Foundation
import Observation
import EffectCore

enum ScenePhase: String, Sendable {
    case waitingForText
    case intro
    case settle
    case idle
    case stopped
}

@MainActor
@Observable
final class EffectDirector {
    var phase: ScenePhase = .waitingForText
    var resolved = ResolvedScene(quality: .unresolved)
    var replayRequested = false
    var seed: UInt64 = 0

    func apply(_ scene: ResolvedScene, seed: UInt64) {
        self.seed = seed
        resolved = scene
        replayRequested = false
        if scene.quality == .unresolved {
            phase = .idle
            return
        }
        phase = .waitingForText
    }

    func noteCalendarTextVisible() {
        guard phase == .waitingForText else { return }
        if resolved.introPlays && resolved.quality != .resolvedStatic {
            phase = .intro
        } else {
            phase = .idle
        }
    }

    func noteIntroFinished() {
        guard phase == .intro else { return }
        phase = .settle
    }

    func noteSettled() {
        if phase == .settle {
            phase = .idle
        }
    }

    func requestReplay() {
        replayRequested = true
        phase = .waitingForText
    }

    func stopForBackground() {
        phase = .stopped
    }

    func resumeFromBackground() {
        if phase == .stopped {
            phase = .idle
        }
    }

    var particlesActive: Bool {
        phase == .intro && resolved.quality == .resolvedLive
    }
}
