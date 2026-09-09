import Foundation
import CalendarCore

public enum MotionPreference: String, Hashable, Sendable, Codable, CaseIterable {
    case vivid
    case gentle
    case still
}

public enum AmbientPreference: String, Hashable, Sendable, Codable, CaseIterable {
    case yen
    case hienSom
    case muaXa
    case quatTrua
}

public enum InspirationRegion: String, Hashable, Sendable, Codable, CaseIterable {
    case north
    case central
    case south
    case neutral
}

public struct UserPreferences: Hashable, Sendable, Codable {
    public var schemaVersion: Int
    public var motion: MotionPreference
    public var ambient: AmbientPreference
    public var paperCuesEnabled: Bool
    public var eventCuesEnabled: Bool
    public var inspirationRegion: InspirationRegion
    public var widgetPrivacy: WidgetPrivacy
    public var deliveryZoneRaw: String
    public var almanacVisible: Bool

    public static let currentSchema = 1

    public static let fresh = UserPreferences(
        schemaVersion: currentSchema,
        motion: .gentle,
        ambient: .yen,
        paperCuesEnabled: false,
        eventCuesEnabled: false,
        inspirationRegion: .neutral,
        widgetPrivacy: .hidden,
        deliveryZoneRaw: TimeZoneIdentifier.vietnam.rawValue,
        almanacVisible: true
    )

    public var deliveryZone: TimeZoneIdentifier {
        TimeZoneIdentifier(deliveryZoneRaw)
    }

    public mutating func silenceAllAudio() {
        ambient = .yen
        paperCuesEnabled = false
        eventCuesEnabled = false
    }
}

public struct UserPreferencesStore {
    public static let payloadKey = "lich-nha-user-preferences"
    public static let legacyAlmanacKey = "almanacLayerEnabled"

    private let defaults: UserDefaults
    private let legacyDefaults: UserDefaults

    public init(defaults: UserDefaults, legacyDefaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.legacyDefaults = legacyDefaults
    }

    public static func appGroupDefaults() -> UserDefaults {
        UserDefaults(suiteName: PersonalSchema.appGroupID) ?? .standard
    }

    public static func makeShared() -> UserPreferencesStore {
        UserPreferencesStore(defaults: appGroupDefaults())
    }

    public func load() -> UserPreferences {
        migrateLegacyAlmanacIfNeeded()
        guard let data = defaults.data(forKey: Self.payloadKey) else {
            return .fresh
        }
        guard var loaded = try? JSONDecoder().decode(UserPreferences.self, from: data) else {
            return .fresh
        }
        if loaded.schemaVersion < UserPreferences.currentSchema {
            loaded.schemaVersion = UserPreferences.currentSchema
            save(loaded)
        }
        return loaded
    }

    public func save(_ preferences: UserPreferences) {
        var copy = preferences
        copy.schemaVersion = UserPreferences.currentSchema
        if let data = try? JSONEncoder().encode(copy) {
            defaults.set(data, forKey: Self.payloadKey)
        }
        legacyDefaults.set(copy.almanacVisible, forKey: Self.legacyAlmanacKey)
    }

    public func reset() {
        defaults.removeObject(forKey: Self.payloadKey)
        save(.fresh)
    }

    private func migrateLegacyAlmanacIfNeeded() {
        guard defaults.data(forKey: Self.payloadKey) == nil else { return }
        guard legacyDefaults.object(forKey: Self.legacyAlmanacKey) != nil else { return }
        var prefs = UserPreferences.fresh
        prefs.almanacVisible = legacyDefaults.bool(forKey: Self.legacyAlmanacKey)
        save(prefs)
    }
}
