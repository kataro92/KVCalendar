import Foundation
import CalendarCore

public struct WidgetSnapshot: Hashable, Sendable, Codable {
    public var civilYear: Int
    public var civilMonth: Int
    public var civilDay: Int
    public var weekday: Int
    public var lunarDay: Int
    public var lunarMonth: Int
    public var lunarIsLeap: Bool
    public var publicOccurrenceLabel: String?
    public var personalHomeLabel: String?
    public var deepLink: String
    public var generatedAt: Date
    public var expiresAfter: Date

    public init(
        civilYear: Int,
        civilMonth: Int,
        civilDay: Int,
        weekday: Int,
        lunarDay: Int,
        lunarMonth: Int,
        lunarIsLeap: Bool,
        publicOccurrenceLabel: String?,
        personalHomeLabel: String?,
        deepLink: String,
        generatedAt: Date,
        expiresAfter: Date
    ) {
        self.civilYear = civilYear
        self.civilMonth = civilMonth
        self.civilDay = civilDay
        self.weekday = weekday
        self.lunarDay = lunarDay
        self.lunarMonth = lunarMonth
        self.lunarIsLeap = lunarIsLeap
        self.publicOccurrenceLabel = publicOccurrenceLabel
        self.personalHomeLabel = personalHomeLabel
        self.deepLink = deepLink
        self.generatedAt = generatedAt
        self.expiresAfter = expiresAfter
    }

    public var civilDate: CivilDate {
        CivilDate(year: civilYear, month: civilMonth, day: civilDay)
    }
}

public struct WidgetSnapshotFile: Hashable, Sendable, Codable {
    public var displayZone: String
    public var snapshots: [WidgetSnapshot]

    public init(displayZone: String, snapshots: [WidgetSnapshot]) {
        self.displayZone = displayZone
        self.snapshots = snapshots
    }
}

public struct WidgetPersonalInput: Hashable, Sendable {
    public var title: String
    public var notes: String?
    public var privacyRaw: String

    public init(title: String, notes: String? = nil, privacyRaw: String) {
        self.title = title
        self.notes = notes
        self.privacyRaw = privacyRaw
    }
}

public enum WidgetSnapshotBuilder {
    public static let genericPersonalMarker = "Ngày gia đình"
    public static let appGroupID = "group.vn.lichnha.app"

    public static func deepLink(civil: CivilDate) -> String {
        let month = String(format: "%02d", civil.month)
        let day = String(format: "%02d", civil.day)
        return "lichnha://day/\(civil.year)-\(month)-\(day)"
    }

    public static func build(
        day: CalendarDay,
        publicTitles: [String],
        personal: [WidgetPersonalInput],
        now: Date,
        displayZone: TimeZoneIdentifier
    ) -> WidgetSnapshot {
        let expiry = WidgetTimelinePlanning.nextMidnight(after: now, civil: day.civilDate, zone: displayZone)
        return WidgetSnapshot(
            civilYear: day.civilDate.year,
            civilMonth: day.civilDate.month,
            civilDay: day.civilDate.day,
            weekday: day.weekday,
            lunarDay: day.lunarDate.day,
            lunarMonth: day.lunarDate.month,
            lunarIsLeap: day.lunarDate.isLeapMonth,
            publicOccurrenceLabel: publicTitles.first,
            personalHomeLabel: WidgetPrivacyFilter.homeLabel(personal: personal),
            deepLink: deepLink(civil: day.civilDate),
            generatedAt: now,
            expiresAfter: expiry
        )
    }

    public static func dateOnly(day: CalendarDay, now: Date, displayZone: TimeZoneIdentifier) -> WidgetSnapshot {
        build(day: day, publicTitles: [], personal: [], now: now, displayZone: displayZone)
    }
}

public enum WidgetPrivacyFilter {
    public static func homeLabel(personal: [WidgetPersonalInput]) -> String? {
        guard let first = personal.first else { return nil }
        switch first.privacyRaw {
        case "publicTitle":
            return first.title
        case "genericMarker":
            return WidgetSnapshotBuilder.genericPersonalMarker
        default:
            return nil
        }
    }

    public static func visiblePersonalLabel(_ stored: String?, lockScreen: Bool) -> String? {
        if lockScreen { return nil }
        return stored
    }

    public static func containsPrivateContent(_ snapshot: WidgetSnapshot, title: String, notes: String?) -> Bool {
        if snapshot.personalHomeLabel == title { return true }
        if let notes, !notes.isEmpty, snapshot.personalHomeLabel == notes { return true }
        if let notes, snapshot.publicOccurrenceLabel == notes { return true }
        return false
    }
}

public enum WidgetTimelinePlanning {
    public static func nextMidnight(after now: Date, civil: CivilDate, zone: TimeZoneIdentifier) -> Date {
        let tz = TimeZone(identifier: zone.rawValue) ?? TimeZone(secondsFromGMT: 7 * 3600)!
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = tz
        let nextCivil = civil.adding(days: 1)
        var parts = DateComponents()
        parts.year = nextCivil.year
        parts.month = nextCivil.month
        parts.day = nextCivil.day
        parts.hour = 0
        parts.minute = 1
        parts.second = 0
        return calendar.date(from: parts) ?? now.addingTimeInterval(24 * 3600)
    }

    public static func isToday(_ snapshot: WidgetSnapshot, now: Date, zone: TimeZoneIdentifier) -> Bool {
        let context = TimeContext(displayZone: zone, deliveryZone: zone, now: { now })
        return snapshot.civilDate == context.today(in: zone)
    }

    public static func snapshotForDisplay(
        stored: [WidgetSnapshot],
        now: Date,
        zone: TimeZoneIdentifier,
        fallback: WidgetSnapshot
    ) -> WidgetSnapshot {
        let context = TimeContext(displayZone: zone, deliveryZone: zone, now: { now })
        let today = context.today(in: zone)
        if let match = stored.first(where: { $0.civilDate == today }) {
            return match
        }
        return fallback
    }

    public static func timelineDates(
        from now: Date,
        zone: TimeZoneIdentifier,
        dayCount: Int = 3
    ) -> [CivilDate] {
        let context = TimeContext(displayZone: zone, deliveryZone: zone, now: { now })
        let start = context.today(in: zone)
        return (0..<dayCount).map { start.adding(days: $0) }
    }
}

public enum WidgetSnapshotStore {
    public static let fileName = "widget-snapshots.json"

    public static func appGroupDirectory() -> URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: WidgetSnapshotBuilder.appGroupID)
    }

    public static func save(_ file: WidgetSnapshotFile, to directory: URL) throws {
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent(fileName)
        let data = try JSONEncoder().encode(file)
        try data.write(to: url, options: .atomic)
    }

    public static func load(from directory: URL) throws -> WidgetSnapshotFile {
        let url = directory.appendingPathComponent(fileName)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(WidgetSnapshotFile.self, from: data)
    }

    public static func saveToSharedContainer(_ file: WidgetSnapshotFile) throws {
        let directory = appGroupDirectory()
            ?? FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("LichNhaWidget", isDirectory: true)
        try save(file, to: directory)
    }

    public static func loadFromSharedContainer() -> WidgetSnapshotFile? {
        let directory = appGroupDirectory()
            ?? FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("LichNhaWidget", isDirectory: true)
        return try? load(from: directory)
    }
}
