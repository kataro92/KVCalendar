import Foundation
import CalendarCore
import CryptoKit

public struct ContentCatalog: Sendable {
    public var packs: [ContentPack]
    public var usedFallback: Bool
    public var activeVersionLabel: String

    public init(packs: [ContentPack], usedFallback: Bool) {
        self.packs = packs
        self.usedFallback = usedFallback
        self.activeVersionLabel = packs.map(\.packVersion).joined(separator: ", ")
    }

    public var sources: [SourceRecord] {
        var seen = Set<String>()
        var result: [SourceRecord] = []
        for pack in packs {
            for source in pack.sources where seen.insert(source.id).inserted {
                result.append(source)
            }
        }
        return result
    }

    public func occurrences(on day: CalendarDay) -> [CalendarOccurrence] {
        packs.flatMap { pack in
            guard (pack.effectiveRange.from...pack.effectiveRange.to).contains(day.civilDate.year) else {
                return [CalendarOccurrence]()
            }
            return pack.occurrences.filter { $0.matches(day: day) && $0.taxonomy != .personal }
        }
    }

    public func source(id: String) -> SourceRecord? {
        sources.first { $0.id == id }
    }

    public static func load(from directory: URL, cacheDirectory: URL) throws -> ContentCatalog {
        let manifestURL = directory.appendingPathComponent("manifest.json")
        do {
            let catalog = try loadManifest(manifestURL, directory: directory)
            try persist(from: directory, to: cacheDirectory)
            return ContentCatalog(packs: catalog, usedFallback: false)
        } catch {
            let fallbackManifest = cacheDirectory.appendingPathComponent("manifest.json")
            let cached = try loadManifest(fallbackManifest, directory: cacheDirectory)
            return ContentCatalog(packs: cached, usedFallback: true)
        }
    }

    public static func loadFromBundle(_ bundle: Bundle, cacheDirectory: URL) throws -> ContentCatalog {
        let directories = [
            bundle.url(forResource: "ContentPacks", withExtension: nil),
            bundle.url(forResource: "manifest", withExtension: "json", subdirectory: "ContentPacks")?
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
        case restrictedSource(String)
        case personalOccurrence(String)
        case missingSource(String)
    }
}

private func loadManifest(_ url: URL, directory: URL) throws -> [ContentPack] {
    let data = try Data(contentsOf: url)
    let manifest = try JSONDecoder().decode(ContentManifest.self, from: data)
    return try manifest.packs.map { item in
        let packURL = directory.appendingPathComponent(item.file)
        return try decodeValidatedPack(at: packURL)
    }
}

private func decodeValidatedPack(at url: URL) throws -> ContentPack {
    let data = try Data(contentsOf: url)
    try verifyChecksum(data, packName: url.lastPathComponent)
    let pack = try JSONDecoder().decode(ContentPack.self, from: data)
    for source in pack.sources where source.licenseStatus == .restricted {
        throw ContentCatalog.CatalogError.restrictedSource(source.id)
    }
    let sourceIDs = Set(pack.sources.map(\.id))
    for occurrence in pack.occurrences {
        if occurrence.taxonomy == .personal {
            throw ContentCatalog.CatalogError.personalOccurrence(occurrence.id)
        }
        if let sourceID = occurrence.sourceID, !sourceIDs.contains(sourceID) {
            throw ContentCatalog.CatalogError.missingSource(occurrence.id)
        }
    }
    return pack
}

private func verifyChecksum(_ data: Data, packName: String) throws {
    let root = try JSONSerialization.jsonObject(with: data)
    guard let object = root as? [String: Any] else {
        throw ContentCatalog.CatalogError.checksumMismatch(packName)
    }
    let payload: [String: Any] = [
        "sources": object["sources"] ?? [],
        "occurrences": object["occurrences"] ?? [],
        "almanac": object["almanac"] ?? NSNull(),
    ]
    var options: JSONSerialization.WritingOptions = [.sortedKeys]
    options.insert(.withoutEscapingSlashes)
    let canonical = try JSONSerialization.data(withJSONObject: payload, options: options)
    let digest = SHA256.hash(data: canonical)
    let expected = digest.map { String(format: "%02x", $0) }.joined()
    guard let listed = object["recordsChecksum"] as? String, listed == expected else {
        throw ContentCatalog.CatalogError.checksumMismatch("\(packName) listed=\(object["recordsChecksum"] ?? "") got=\(expected)")
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
