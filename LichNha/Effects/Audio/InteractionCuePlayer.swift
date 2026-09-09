import EffectCore

@MainActor
final class InteractionCuePlayer {
    private let coordinator: AmbientAudioCoordinator

    init(coordinator: AmbientAudioCoordinator) {
        self.coordinator = coordinator
    }

    func playPaper() {
        guard coordinator.mayPlayPaperCue else { return }
    }

    func playEvent() {
        guard coordinator.mayPlayEventCue else { return }
    }
}
