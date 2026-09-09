import Foundation
import ContentCore
import CryptoKit

public struct EffectCatalog: Sendable {
    public var packs: [EffectPack]
    public var usedFallback: Bool

    public init(packs: [EffectPack], usedFallback: Bool) {
        self.packs = packs
        self.usedFallback = usedFallback
    }

    public var cues: [EffectCue] {
        packs.flatMap(\.cues)
    }

    public var assets: [AssetRecord] {
        packs.flatMap(\.assets)
    }

    public var versionLabel: String {
        let versions = packs.map(\.packVersion)
        return versions.isEmpty ? "chưa có pack" : versions.joined(separator: ", ")
    }

    public static func load(from directory: URL, cacheDirectory: URL) throws -> EffectCatalog {
        let manifestURL = directory.appendingPathComponent("manifest.json")
        do {
            let packs = try loadManifest(manifestURL, directory: directory)
            try persist(from: directory, to: cacheDirectory)
            return EffectCatalog(packs: packs, usedFallback: false)
        } catch {
            let fallbackManifest = cacheDirectory.appendingPathComponent("manifest.json")
            guard FileManager.default.fileExists(atPath: fallbackManifest.path) else {
                throw error
            }
            let cached = try loadManifest(fallbackManifest, directory: cacheDirectory)
            return EffectCatalog(packs: cached, usedFallback: true)
        }
    }

    public static func loadFromBundle(_ bundle: Bundle, cacheDirectory: URL) throws -> EffectCatalog {
        let directories = [
            bundle.url(forResource: "EffectPacks", withExtension: nil),
            bundle.url(forResource: "manifest", withExtension: "json", subdirectory: "EffectPacks")?
                .deletingLastPathComponent(),
            bundle.url(forResource: "manifest", withExtension: "json")?
                .deletingLastPathComponent(),
        ].compactMap { $0 }
        guard let directory = directories.first(where: {
            FileManager.default.fileExists(atPath: $0.appendingPathComponent("manifest.json").path)
        }) else {
            throw CatalogError.missingManifest
        }
        return try load(from: directory, cacheDirectory: cacheDirectory)
    }

    public enum CatalogError: Error, Equatable {
        case missingManifest
        case checksumMismatch(String)
        case restrictedLicense(String)
        case missingReference(String)
        case generativeFlag(String)
        case missingPoster(String)
        case unknownGenerationMethod(String)
    }
}

public enum EffectPackChecksum {
    public static func digest(cues: Any, assets: Any) throws -> String {
        let payload: [String: Any] = ["assets": assets, "cues": cues]
        var options: JSONSerialization.WritingOptions = [.sortedKeys]
        options.insert(.withoutEscapingSlashes)
        let canonical = try JSONSerialization.data(withJSONObject: payload, options: options)
        return SHA256.hash(data: canonical).map { String(format: "%02x", $0) }.joined()
    }
}

public enum EffectPackValidator {
    public static func validate(_ pack: EffectPack) throws {
        if pack.licenseRestricted {
            if let asset = pack.assets.first(where: { $0.licenseStatus == .restricted }) {
                throw EffectCatalog.CatalogError.restrictedLicense(asset.id)
            }
        }
        for asset in pack.assets {
            if asset.generationMethod == .imageTo3D,
               asset.sourceReference.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw EffectCatalog.CatalogError.missingReference(asset.id)
            }
            if asset.kind == .model && (asset.posterID == nil || asset.posterID?.isEmpty == true) {
                throw EffectCatalog.CatalogError.missingPoster(asset.id)
            }
            if assetLooksLikeNationalFlag(asset) && asset.generationMethod != .manual {
                throw EffectCatalog.CatalogError.generativeFlag(asset.id)
            }
        }
        for cue in pack.cues where cue.nationalFlag {
            if let asset = pack.assets.first(where: { $0.id == cue.fallbackPosterID }),
               asset.generationMethod == .imageTo3D {
                throw EffectCatalog.CatalogError.generativeFlag(asset.id)
            }
        }
    }

    private static func assetLooksLikeNationalFlag(_ asset: AssetRecord) -> Bool {
        let haystack = (asset.id + " " + asset.sourceReference).lowercased()
        return haystack.contains("flag") || haystack.contains("quoc-ky") || haystack.contains("quốc kỳ")
    }
}

private extension EffectPack {
    var licenseRestricted: Bool {
        assets.contains { $0.licenseStatus == .restricted }
    }
}

private func loadManifest(_ url: URL, directory: URL) throws -> [EffectPack] {
    let data = try Data(contentsOf: url)
    let manifest = try JSONDecoder().decode(EffectManifest.self, from: data)
    return try manifest.packs.map { item in
        let packURL = directory.appendingPathComponent(item.file)
        return try decodeValidatedPack(at: packURL)
    }
}

private func decodeValidatedPack(at url: URL) throws -> EffectPack {
    let data = try Data(contentsOf: url)
    try verifyChecksum(data, packName: url.lastPathComponent)
    let pack = try JSONDecoder().decode(EffectPack.self, from: data)
    try EffectPackValidator.validate(pack)
    return pack
}

private func verifyChecksum(_ data: Data, packName: String) throws {
    let root = try JSONSerialization.jsonObject(with: data)
    guard let object = root as? [String: Any] else {
        throw EffectCatalog.CatalogError.checksumMismatch(packName)
    }
    let expected = try EffectPackChecksum.digest(
        cues: object["cues"] ?? [],
        assets: object["assets"] ?? []
    )
    guard let listed = object["recordsChecksum"] as? String, listed == expected else {
        throw EffectCatalog.CatalogError.checksumMismatch(
            "\(packName) listed=\(object["recordsChecksum"] ?? "") got=\(expected)"
        )
    }
}

private func persist(from directory: URL, to cacheDirectory: URL) throws {
    try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    let names = try FileManager.default.contentsOfDirectory(atPath: directory.path)
    for name in names where name.hasSuffix(".json") {
        let from = directory.appendingPathComponent(name)
        let to = cacheDirectory.appendingPathComponent(name)
        if FileManager.default.fileExists(atPath: to.path) {
            try FileManager.default.removeItem(at: to)
        }
        try FileManager.default.copyItem(at: from, to: to)
    }
}

private struct EffectManifest: Codable {
    var packs: [Item]

    struct Item: Codable {
        var id: String
        var file: String
    }
}
