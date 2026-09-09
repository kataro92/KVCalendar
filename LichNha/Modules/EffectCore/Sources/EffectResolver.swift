import Foundation

public enum EffectResolver {
    public static func resolve(_ input: EffectResolverInput) -> ResolvedScene {
        guard let cue = selectedCue(from: input) else {
            return ResolvedScene(quality: .unresolved, fallbackReason: "no-cue")
        }

        let assetsByID = Dictionary(uniqueKeysWithValues: input.assets.map { ($0.id, $0) })
        var fallbackReason: String?
        var quality = quality(for: input, cue: cue)

        if cue.posterOnly {
            quality = .resolvedStatic
            fallbackReason = fallbackReason ?? "poster-only"
        }

        if let missing = missingReason(cue: cue, assetsByID: assetsByID, missingIDs: input.missingAssetIDs) {
            quality = .resolvedStatic
            fallbackReason = missing
        }

        let allowsConfetti = !(cue.noConfetti || cue.solemn || cue.nationalFlag)
        let allowsAudio = !(cue.noAudio || cue.solemn)
        let introPlays = cue.allowsAutoPlay
            && quality != .unresolved
            && (!input.introSeenToday || input.replayRequested)

        return ResolvedScene(
            quality: quality,
            heroCueID: cue.id,
            posterID: cue.fallbackPosterID,
            allowsConfetti: allowsConfetti,
            allowsAudio: allowsAudio,
            fallbackReason: fallbackReason,
            introPlays: introPlays
        )
    }

    public static func selectedCue(from input: EffectResolverInput) -> EffectCue? {
        let specific = input.cues.filter { cue in
            if let occurrenceID = cue.triggerOccurrenceID {
                return input.occurrenceIDs.contains(occurrenceID)
            }
            if let index = cue.triggerSolarTermIndex {
                return input.solarTermIndex == index
            }
            return false
        }
        if let chosen = specific.max(by: cueOrder) {
            return chosen
        }
        return input.cues
            .filter { $0.triggerOccurrenceID == nil && $0.triggerSolarTermIndex == nil }
            .max(by: cueOrder)
    }

    private static func cueOrder(_ lhs: EffectCue, _ rhs: EffectCue) -> Bool {
        if lhs.priority != rhs.priority {
            return lhs.priority < rhs.priority
        }
        return lhs.id > rhs.id
    }

    private static func quality(for input: EffectResolverInput, cue: EffectCue) -> SceneQuality {
        let capability = EffectCapabilitySnapshot(
            lowPower: input.lowPower,
            thermalSevere: input.thermalSevere,
            reduceMotion: input.reduceMotion,
            dimFlashingLights: input.dimFlashingLights
        )
        if capability.forcesPoster || input.effectLevel == .still {
            return .resolvedStatic
        }
        if input.effectLevel == .gentle {
            return .resolvedGentle
        }
        return .resolvedLive
    }

    private static func missingReason(
        cue: EffectCue,
        assetsByID: [String: AssetRecord],
        missingIDs: Set<String>
    ) -> String? {
        if missingIDs.contains(cue.fallbackPosterID) {
            return "missing-asset"
        }
        if assetsByID[cue.fallbackPosterID] == nil, !inputAssetsEmpty(assetsByID) {
            return "missing-asset"
        }
        if let asset = assetsByID[cue.fallbackPosterID], asset.licenseStatus == .restricted {
            return "restricted-license"
        }
        for asset in assetsByID.values {
            if asset.generationMethod == .imageTo3D && asset.sourceReference.trimmingCharacters(in: .whitespaces).isEmpty {
                return "missing-reference"
            }
            if asset.kind == .model && (asset.posterID == nil || asset.posterID?.isEmpty == true) {
                return "missing-poster"
            }
        }
        return nil
    }

    private static func inputAssetsEmpty(_ assetsByID: [String: AssetRecord]) -> Bool {
        assetsByID.isEmpty
    }
}
