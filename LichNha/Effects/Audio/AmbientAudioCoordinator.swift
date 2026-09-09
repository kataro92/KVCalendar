import AVFoundation
import EffectCore
#if canImport(UIKit)
import UIKit
#endif

@MainActor
final class AmbientAudioCoordinator {
    var settings: AudioLayerSettings = .releaseDefault
    let player = AmbientSoundPlayer()
    private var callActive = false
    private var headphonesJustRemoved = false
    private var observers: [NSObjectProtocol] = []

    func start() {
        configureSession()
        listenForInterruptions()
        apply()
    }

    func stop() {
        player.stop()
        observers.forEach(NotificationCenter.default.removeObserver)
        observers.removeAll()
    }

    func apply() {
        if mayPlayAmbient {
            player.start(bed: settings.ambient)
        } else {
            player.stop()
        }
    }

    var mayPlayAmbient: Bool {
        AudioPlaybackPolicy.mayPlayAmbient(
            layerEnabled: settings.ambientLayerEnabled,
            silentHardware: silentHardware,
            voiceOver: voiceOverRunning,
            otherAudioPlaying: otherAudioPlaying,
            callActive: callActive
        )
    }

    var mayPlayPaperCue: Bool {
        AudioPlaybackPolicy.mayPlayCue(
            cueEnabled: settings.paperCuesEnabled,
            silentHardware: silentHardware,
            voiceOver: voiceOverRunning,
            otherAudioPlaying: otherAudioPlaying,
            callActive: callActive,
            headphonesJustRemoved: headphonesJustRemoved
        )
    }

    var mayPlayEventCue: Bool {
        AudioPlaybackPolicy.mayPlayCue(
            cueEnabled: settings.eventCuesEnabled,
            silentHardware: silentHardware,
            voiceOver: voiceOverRunning,
            otherAudioPlaying: otherAudioPlaying,
            callActive: callActive,
            headphonesJustRemoved: headphonesJustRemoved
        )
    }

    private var silentHardware: Bool {
        AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint
    }

    private var otherAudioPlaying: Bool {
        AVAudioSession.sharedInstance().isOtherAudioPlaying
    }

    private var voiceOverRunning: Bool {
        #if canImport(UIKit)
        UIAccessibility.isVoiceOverRunning
        #else
        false
        #endif
    }

    private func configureSession() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        try? session.setActive(true, options: [])
    }

    private func listenForInterruptions() {
        let center = NotificationCenter.default
        observers.append(
            center.addObserver(forName: AVAudioSession.interruptionNotification, object: nil, queue: .main) { [weak self] note in
                let type = note.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt
                Task { @MainActor in
                    self?.handleInterruption(type: type)
                }
            }
        )
        observers.append(
            center.addObserver(forName: AVAudioSession.routeChangeNotification, object: nil, queue: .main) { [weak self] note in
                let reason = note.userInfo?[AVAudioSessionRouteChangeReasonKey] as? UInt
                Task { @MainActor in
                    self?.handleRouteChange(reason: reason)
                }
            }
        )
        #if canImport(UIKit)
        observers.append(
            center.addObserver(forName: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
                Task { @MainActor in
                    self?.apply()
                }
            }
        )
        #endif
    }

    private func handleInterruption(type: UInt?) {
        if type == AVAudioSession.InterruptionType.began.rawValue {
            callActive = true
            player.stop()
        } else {
            callActive = false
            apply()
        }
    }

    private func handleRouteChange(reason: UInt?) {
        if reason == AVAudioSession.RouteChangeReason.oldDeviceUnavailable.rawValue {
            headphonesJustRemoved = true
            player.stop()
        } else {
            headphonesJustRemoved = false
            apply()
        }
    }
}
