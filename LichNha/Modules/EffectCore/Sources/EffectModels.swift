import Foundation
import ContentCore

public struct EffectCue: Hashable, Sendable, Codable, Identifiable {
    public var id: String
    public var triggerOccurrenceID: String?
    public var triggerSolarTermIndex: Int?
    public var tone: String
    public var priority: Int
    public var allowsAutoPlay: Bool
    public var nationalFlag: Bool
    public var solemn: Bool
    public var noConfetti: Bool
    public var noAudio: Bool
    public var posterOnly: Bool
    public var fallbackPosterID: String

    public init(
        id: String,
        triggerOccurrenceID: String? = nil,
        triggerSolarTermIndex: Int? = nil,
        tone: String,
        priority: Int,
        allowsAutoPlay: Bool = true,
        nationalFlag: Bool = false,
        solemn: Bool = false,
        noConfetti: Bool = false,
        noAudio: Bool = false,
        posterOnly: Bool = false,
        fallbackPosterID: String
    ) {
        self.id = id
        self.triggerOccurrenceID = triggerOccurrenceID
        self.triggerSolarTermIndex = triggerSolarTermIndex
        self.tone = tone
        self.priority = priority
        self.allowsAutoPlay = allowsAutoPlay
        self.nationalFlag = nationalFlag
        self.solemn = solemn
        self.noConfetti = noConfetti
        self.noAudio = noAudio
        self.posterOnly = posterOnly
        self.fallbackPosterID = fallbackPosterID
    }
}

public struct AssetRecord: Hashable, Sendable, Codable, Identifiable {
    public var id: String
    public var kind: AssetKind
    public var sourceReference: String
    public var generationMethod: GenerationMethod
    public var checksum: String
    public var licenseStatus: ContentCore.LicenseStatus
    public var posterID: String?

    public init(
        id: String,
        kind: AssetKind,
        sourceReference: String,
        generationMethod: GenerationMethod,
        checksum: String,
        licenseStatus: ContentCore.LicenseStatus,
        posterID: String? = nil
    ) {
        self.id = id
        self.kind = kind
        self.sourceReference = sourceReference
        self.generationMethod = generationMethod
        self.checksum = checksum
        self.licenseStatus = licenseStatus
        self.posterID = posterID
    }
}

public enum AssetKind: String, Hashable, Sendable, Codable {
    case model
    case texture
    case sprite
    case poster
    case audio
}

public enum GenerationMethod: String, Hashable, Sendable, Codable {
    case manual
    case captured
    case imageTo3D
    case soundGeneration
}

public struct EffectPack: Hashable, Sendable, Codable {
    public var schemaVersion: String
    public var packVersion: String
    public var recordsChecksum: String
    public var cues: [EffectCue]
    public var assets: [AssetRecord]

    public init(
        schemaVersion: String,
        packVersion: String,
        recordsChecksum: String,
        cues: [EffectCue],
        assets: [AssetRecord]
    ) {
        self.schemaVersion = schemaVersion
        self.packVersion = packVersion
        self.recordsChecksum = recordsChecksum
        self.cues = cues
        self.assets = assets
    }
}

public enum SceneQuality: String, Hashable, Sendable, Codable {
    case unresolved
    case resolvedLive
    case resolvedGentle
    case resolvedStatic
}

public struct ResolvedScene: Hashable, Sendable {
    public var quality: SceneQuality
    public var heroCueID: String?
    public var posterID: String?
    public var allowsConfetti: Bool
    public var allowsAudio: Bool
    public var fallbackReason: String?
    public var introPlays: Bool

    public init(
        quality: SceneQuality,
        heroCueID: String? = nil,
        posterID: String? = nil,
        allowsConfetti: Bool = false,
        allowsAudio: Bool = false,
        fallbackReason: String? = nil,
        introPlays: Bool = false
    ) {
        self.quality = quality
        self.heroCueID = heroCueID
        self.posterID = posterID
        self.allowsConfetti = allowsConfetti
        self.allowsAudio = allowsAudio
        self.fallbackReason = fallbackReason
        self.introPlays = introPlays
    }
}

public enum EffectLevel: String, Hashable, Sendable, Codable {
    case vivid
    case gentle
    case still
}

public struct EffectResolverInput: Hashable, Sendable {
    public var occurrenceIDs: [String]
    public var solarTermIndex: Int?
    public var cues: [EffectCue]
    public var assets: [AssetRecord]
    public var effectLevel: EffectLevel
    public var reduceMotion: Bool
    public var dimFlashingLights: Bool
    public var lowPower: Bool
    public var thermalSevere: Bool
    public var introSeenToday: Bool
    public var replayRequested: Bool
    public var missingAssetIDs: Set<String>

    public init(
        occurrenceIDs: [String],
        solarTermIndex: Int? = nil,
        cues: [EffectCue],
        assets: [AssetRecord] = [],
        effectLevel: EffectLevel = .gentle,
        reduceMotion: Bool = false,
        dimFlashingLights: Bool = false,
        lowPower: Bool = false,
        thermalSevere: Bool = false,
        introSeenToday: Bool = false,
        replayRequested: Bool = false,
        missingAssetIDs: Set<String> = []
    ) {
        self.occurrenceIDs = occurrenceIDs
        self.solarTermIndex = solarTermIndex
        self.cues = cues
        self.assets = assets
        self.effectLevel = effectLevel
        self.reduceMotion = reduceMotion
        self.dimFlashingLights = dimFlashingLights
        self.lowPower = lowPower
        self.thermalSevere = thermalSevere
        self.introSeenToday = introSeenToday
        self.replayRequested = replayRequested
        self.missingAssetIDs = missingAssetIDs
    }
}

public struct EffectCapabilitySnapshot: Hashable, Sendable {
    public var lowPower: Bool
    public var thermalSevere: Bool
    public var reduceMotion: Bool
    public var dimFlashingLights: Bool

    public init(
        lowPower: Bool = false,
        thermalSevere: Bool = false,
        reduceMotion: Bool = false,
        dimFlashingLights: Bool = false
    ) {
        self.lowPower = lowPower
        self.thermalSevere = thermalSevere
        self.reduceMotion = reduceMotion
        self.dimFlashingLights = dimFlashingLights
    }

    public var forcesPoster: Bool {
        lowPower || thermalSevere || reduceMotion || dimFlashingLights
    }
}

public enum AudioPlaybackPolicy {
    public static func mayPlayAmbient(
        layerEnabled: Bool,
        silentHardware: Bool,
        voiceOver: Bool,
        otherAudioPlaying: Bool,
        callActive: Bool
    ) -> Bool {
        layerEnabled && !silentHardware && !voiceOver && !otherAudioPlaying && !callActive
    }

    public static func mayPlayCue(
        cueEnabled: Bool,
        silentHardware: Bool,
        voiceOver: Bool,
        otherAudioPlaying: Bool,
        callActive: Bool,
        headphonesJustRemoved: Bool
    ) -> Bool {
        if headphonesJustRemoved { return false }
        return mayPlayAmbient(
            layerEnabled: cueEnabled,
            silentHardware: silentHardware,
            voiceOver: voiceOver,
            otherAudioPlaying: otherAudioPlaying,
            callActive: callActive
        )
    }
}

public enum AmbientBed: String, Hashable, Sendable, Codable, CaseIterable {
    case yen
    case hienSom
    case muaXa
    case quatTrua
}

public struct AudioLayerSettings: Hashable, Sendable {
    public var ambient: AmbientBed
    public var paperCuesEnabled: Bool
    public var eventCuesEnabled: Bool

    public init(
        ambient: AmbientBed = .yen,
        paperCuesEnabled: Bool = false,
        eventCuesEnabled: Bool = false
    ) {
        self.ambient = ambient
        self.paperCuesEnabled = paperCuesEnabled
        self.eventCuesEnabled = eventCuesEnabled
    }

    public static let releaseDefault = AudioLayerSettings()

    public var ambientLayerEnabled: Bool {
        ambient != .yen
    }
}

public enum OrdinaryDaySeed {
    public static func value(year: Int, month: Int, day: Int) -> UInt64 {
        UInt64(year) * 10_000 + UInt64(month) * 100 + UInt64(day)
    }
}
