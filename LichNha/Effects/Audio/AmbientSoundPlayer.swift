import AVFoundation
import EffectCore

@MainActor
final class AmbientSoundPlayer {
    private(set) var activeBed: AmbientBed = .yen
    private(set) var isRunning = false
    private var player: AVAudioPlayer?

    @discardableResult
    func start(bed: AmbientBed) -> Bool {
        guard bed != .yen else {
            stop()
            return false
        }
        guard let url = Bundle.main.url(forResource: resourceName(for: bed), withExtension: "caf") else {
            stop()
            return false
        }
        do {
            let audio = try AVAudioPlayer(contentsOf: url)
            audio.numberOfLoops = -1
            audio.volume = 0
            audio.play()
            fade(to: 0.22)
            player = audio
            activeBed = bed
            isRunning = true
            return true
        } catch {
            stop()
            return false
        }
    }

    func stop() {
        fade(to: 0)
        player?.stop()
        player = nil
        activeBed = .yen
        isRunning = false
    }

    private func fade(to volume: Float) {
        player?.setVolume(volume, fadeDuration: 1.2)
    }

    private func resourceName(for bed: AmbientBed) -> String {
        switch bed {
        case .yen: return "ambient-yen"
        case .hienSom: return "ambient-hien-som"
        case .muaXa: return "ambient-mua-xa"
        case .quatTrua: return "ambient-quat-trua"
        }
    }
}
