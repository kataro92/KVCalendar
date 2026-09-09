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
    public var keepScreenAwake: Bool
    public var lastAmbient: AmbientPreference

    public static let currentSchema = 1

    public init(
        schemaVersion: Int = currentSchema,
        motion: MotionPreference,
        ambient: AmbientPreference,
        paperCuesEnabled: Bool,
        eventCuesEnabled: Bool,
        inspirationRegion: InspirationRegion,
        widgetPrivacy: WidgetPrivacy,
        deliveryZoneRaw: String,
        almanacVisible: Bool,
        keepScreenAwake: Bool = false,
        lastAmbient: AmbientPreference = .hienSom
    ) {
        self.schemaVersion = schemaVersion
        self.motion = motion
        self.ambient = ambient
        self.paperCuesEnabled = paperCuesEnabled
        self.eventCuesEnabled = eventCuesEnabled
        self.inspirationRegion = inspirationRegion
        self.widgetPrivacy = widgetPrivacy
        self.deliveryZoneRaw = deliveryZoneRaw
        self.almanacVisible = almanacVisible
        self.keepScreenAwake = keepScreenAwake
        self.lastAmbient = lastAmbient == .yen ? .hienSom : lastAmbient
    }

    public static let fresh = UserPreferences(
        schemaVersion: currentSchema,
        motion: .gentle,
        ambient: .yen,
        paperCuesEnabled: false,
        eventCuesEnabled: false,
        inspirationRegion: .neutral,
        widgetPrivacy: .hidden,
        deliveryZoneRaw: TimeZoneIdentifier.vietnam.rawValue,
        almanacVisible: true,
        keepScreenAwake: false,
        lastAmbient: .hienSom
    )

    public var deliveryZone: TimeZoneIdentifier {
        TimeZoneIdentifier(deliveryZoneRaw)
    }

    public var isAmbientOn: Bool {
        ambient != .yen
    }

    public mutating func silenceAllAudio() {
        if ambient != .yen {
            lastAmbient = ambient
        }
        ambient = .yen
        paperCuesEnabled = false
        eventCuesEnabled = false
    }

    public mutating func setAmbientEnabled(_ on: Bool) {
        if on {
            ambient = lastAmbient == .yen ? .hienSom : lastAmbient
        } else {
            if ambient != .yen {
                lastAmbient = ambient
            }
            ambient = .yen
        }
    }

    enum CodingKeys: String, CodingKey {
        case schemaVersion
        case motion
        case ambient
        case paperCuesEnabled
        case eventCuesEnabled
        case inspirationRegion
        case widgetPrivacy
        case deliveryZoneRaw
        case almanacVisible
        case keepScreenAwake
        case lastAmbient
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        schemaVersion = try container.decodeIfPresent(Int.self, forKey: .schemaVersion) ?? Self.currentSchema
        motion = try container.decodeIfPresent(MotionPreference.self, forKey: .motion) ?? .gentle
        ambient = try container.decodeIfPresent(AmbientPreference.self, forKey: .ambient) ?? .yen
        paperCuesEnabled = try container.decodeIfPresent(Bool.self, forKey: .paperCuesEnabled) ?? false
        eventCuesEnabled = try container.decodeIfPresent(Bool.self, forKey: .eventCuesEnabled) ?? false
        inspirationRegion = try container.decodeIfPresent(InspirationRegion.self, forKey: .inspirationRegion) ?? .neutral
        widgetPrivacy = try container.decodeIfPresent(WidgetPrivacy.self, forKey: .widgetPrivacy) ?? .hidden
        deliveryZoneRaw = try container.decodeIfPresent(String.self, forKey: .deliveryZoneRaw)
            ?? TimeZoneIdentifier.vietnam.rawValue
        almanacVisible = try container.decodeIfPresent(Bool.self, forKey: .almanacVisible) ?? true
        keepScreenAwake = try container.decodeIfPresent(Bool.self, forKey: .keepScreenAwake) ?? false
        let storedLast = try container.decodeIfPresent(AmbientPreference.self, forKey: .lastAmbient) ?? .hienSom
        lastAmbient = storedLast == .yen ? .hienSom : storedLast
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
