import Testing
import EffectCore

struct AudioBehaviorTests {
    @Test func releaseDefaultIsSilentYenWithCuesOff() {
        let settings = AudioLayerSettings.releaseDefault
        #expect(settings.ambient == .yen)
        #expect(settings.paperCuesEnabled == false)
        #expect(settings.eventCuesEnabled == false)
        #expect(settings.ambientLayerEnabled == false)
    }

    @Test func silentSwitchStopsAmbient() {
        #expect(
            AudioPlaybackPolicy.mayPlayAmbient(
                layerEnabled: true,
                silentHardware: true,
                voiceOver: false,
                otherAudioPlaying: false,
                callActive: false
            ) == false
        )
    }

    @Test func voiceOverStopsAmbient() {
        #expect(
            AudioPlaybackPolicy.mayPlayAmbient(
                layerEnabled: true,
                silentHardware: false,
                voiceOver: true,
                otherAudioPlaying: false,
                callActive: false
            ) == false
        )
    }

    @Test func otherAudioStopsAmbient() {
        #expect(
            AudioPlaybackPolicy.mayPlayAmbient(
                layerEnabled: true,
                silentHardware: false,
                voiceOver: false,
                otherAudioPlaying: true,
                callActive: false
            ) == false
        )
    }

    @Test func callStopsAmbient() {
        #expect(
            AudioPlaybackPolicy.mayPlayAmbient(
                layerEnabled: true,
                silentHardware: false,
                voiceOver: false,
                otherAudioPlaying: false,
                callActive: true
            ) == false
        )
    }

    @Test func headphoneRemovalStopsCues() {
        #expect(
            AudioPlaybackPolicy.mayPlayCue(
                cueEnabled: true,
                silentHardware: false,
                voiceOver: false,
                otherAudioPlaying: false,
                callActive: false,
                headphonesJustRemoved: true
            ) == false
        )
    }

    @Test func paperCueStaysOffWhenDisabled() {
        #expect(
            AudioPlaybackPolicy.mayPlayCue(
                cueEnabled: AudioLayerSettings.releaseDefault.paperCuesEnabled,
                silentHardware: false,
                voiceOver: false,
                otherAudioPlaying: false,
                callActive: false,
                headphonesJustRemoved: false
            ) == false
        )
    }
}
