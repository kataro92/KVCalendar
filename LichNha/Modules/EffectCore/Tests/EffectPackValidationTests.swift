import Foundation
import Testing
import EffectCore
import ContentCore

struct EffectPackValidationTests {
    @Test func checksumMismatchIsRejected() throws {
        let encoded = try encodeCanonical(validPack())
        let directory = try writePackDirectory(data: mutateChecksum(encoded, listed: "deadbeef"))
        let cache = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        #expect(throws: EffectCatalog.CatalogError.self) {
            try EffectCatalog.load(from: directory, cacheDirectory: cache)
        }
    }

    @Test func invalidChecksumFallsBackToLastKnownValid() throws {
        let encoded = try encodeCanonical(validPack())
        let cache = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let goodDir = try writePackDirectory(data: encoded)
        _ = try EffectCatalog.load(from: goodDir, cacheDirectory: cache)

        let brokenDir = try writePackDirectory(data: mutateChecksum(encoded, listed: "00"))
        let catalog = try EffectCatalog.load(from: brokenDir, cacheDirectory: cache)
        #expect(catalog.usedFallback)
        #expect(catalog.cues.contains { $0.id == "cue-quoc-khanh" })
    }

    @Test func missingImageTo3DReferenceIsRejected() {
        let asset = AssetRecord(
            id: "branch-3d",
            kind: .model,
            sourceReference: "",
            generationMethod: .imageTo3D,
            checksum: String(repeating: "a", count: 64),
            licenseStatus: .original,
            posterID: "poster-lap-xuan"
        )
        let pack = EffectPack(
            schemaVersion: "1",
            packVersion: "test",
            recordsChecksum: "x",
            cues: [],
            assets: [asset]
        )
        #expect(throws: EffectCatalog.CatalogError.missingReference("branch-3d")) {
            try EffectPackValidator.validate(pack)
        }
    }

    @Test func generativeNationalFlagIsRejected() {
        let asset = AssetRecord(
            id: "vietnam-flag",
            kind: .poster,
            sourceReference: "flag-photo",
            generationMethod: .imageTo3D,
            checksum: String(repeating: "b", count: 64),
            licenseStatus: .original
        )
        let pack = EffectPack(
            schemaVersion: "1",
            packVersion: "test",
            recordsChecksum: "x",
            cues: [],
            assets: [asset]
        )
        #expect(throws: EffectCatalog.CatalogError.generativeFlag("vietnam-flag")) {
            try EffectPackValidator.validate(pack)
        }
    }

    @Test func modelWithoutPosterIsRejected() {
        let asset = AssetRecord(
            id: "branch-3d",
            kind: .model,
            sourceReference: "assets/references/lap-xuan/front.png",
            generationMethod: .imageTo3D,
            checksum: String(repeating: "c", count: 64),
            licenseStatus: .original
        )
        let pack = EffectPack(
            schemaVersion: "1",
            packVersion: "test",
            recordsChecksum: "x",
            cues: [],
            assets: [asset]
        )
        #expect(throws: EffectCatalog.CatalogError.missingPoster("branch-3d")) {
            try EffectPackValidator.validate(pack)
        }
    }

    @Test func restrictedLicenseIsRejected() {
        let asset = AssetRecord(
            id: "stolen",
            kind: .poster,
            sourceReference: "unknown",
            generationMethod: .manual,
            checksum: String(repeating: "d", count: 64),
            licenseStatus: .restricted
        )
        let pack = EffectPack(
            schemaVersion: "1",
            packVersion: "test",
            recordsChecksum: "x",
            cues: [],
            assets: [asset]
        )
        #expect(throws: EffectCatalog.CatalogError.restrictedLicense("stolen")) {
            try EffectPackValidator.validate(pack)
        }
    }

    @Test func seedResourcePacksPassChecksum() throws {
        guard let directory = effectPackDirectory() else {
            return
        }
        let cache = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let catalog = try EffectCatalog.load(from: directory, cacheDirectory: cache)
        #expect(catalog.usedFallback == false)
        #expect(catalog.cues.contains { $0.id == "cue-quoc-khanh" })
        #expect(catalog.cues.contains { $0.id == "cue-ordinary" })
    }
}

private func validPack() -> EffectPack {
    EffectPack(
        schemaVersion: "1",
        packVersion: "test",
        recordsChecksum: "",
        cues: [
            EffectCue(
                id: "cue-quoc-khanh",
                triggerOccurrenceID: "quoc-khanh",
                tone: "festive-solemn",
                priority: 100,
                nationalFlag: true,
                noConfetti: true,
                fallbackPosterID: "poster-quoc-khanh"
            ),
        ],
        assets: [
            AssetRecord(
                id: "poster-quoc-khanh",
                kind: .poster,
                sourceReference: "procedural",
                generationMethod: .manual,
                checksum: String(repeating: "e", count: 64),
                licenseStatus: .original
            ),
        ]
    )
}

private func checksumFor(pack: EffectPack) throws -> String {
    let data = try JSONEncoder().encode(pack)
    let object = try JSONSerialization.jsonObject(with: data) as? [String: Any]
    return try EffectPackChecksum.digest(cues: object?["cues"] ?? [], assets: object?["assets"] ?? [])
}

private func encodeCanonical(_ pack: EffectPack) throws -> Data {
    var copy = pack
    copy.recordsChecksum = try checksumFor(pack: pack)
    return try JSONEncoder().encode(copy)
}

private func mutateChecksum(_ data: Data, listed: String) throws -> Data {
    var object = try JSONSerialization.jsonObject(with: data) as! [String: Any]
    object["recordsChecksum"] = listed
    return try JSONSerialization.data(withJSONObject: object)
}

private func writePackDirectory(data: Data) throws -> URL {
    let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    try data.write(to: directory.appendingPathComponent("effect-seed.json"))
    let manifest = """
    {"packs":[{"id":"effect-seed","file":"effect-seed.json"}]}
    """
    try Data(manifest.utf8).write(to: directory.appendingPathComponent("manifest.json"))
    return directory
}

private func effectPackDirectory() -> URL? {
    var url = URL(fileURLWithPath: #filePath)
    for _ in 0..<8 {
        let nested = url.appendingPathComponent("LichNha/Resources/EffectPacks/manifest.json")
        if FileManager.default.fileExists(atPath: nested.path) {
            return nested.deletingLastPathComponent()
        }
        let sibling = url.appendingPathComponent("Resources/EffectPacks/manifest.json")
        if FileManager.default.fileExists(atPath: sibling.path) {
            return sibling.deletingLastPathComponent()
        }
        url.deleteLastPathComponent()
    }
    return nil
}
