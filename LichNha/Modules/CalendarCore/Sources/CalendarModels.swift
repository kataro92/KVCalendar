import Foundation

public struct LunarDate: Hashable, Sendable, Codable {
    public var day: Int
    public var month: Int
    public var year: Int
    public var isLeapMonth: Bool
    public var ruleSetVersion: String

    public init(day: Int, month: Int, year: Int, isLeapMonth: Bool, ruleSetVersion: String) {
        self.day = day
        self.month = month
        self.year = year
        self.isLeapMonth = isLeapMonth
        self.ruleSetVersion = ruleSetVersion
    }
}

public struct CanChi: Hashable, Sendable, Codable {
    public var day: StemBranch
    public var month: StemBranch
    public var year: StemBranch

    public init(day: StemBranch, month: StemBranch, year: StemBranch) {
        self.day = day
        self.month = month
        self.year = year
    }
}

public struct StemBranch: Hashable, Sendable, Codable {
    public var stemIndex: Int
    public var branchIndex: Int

    public static let stems = [
        "Giáp", "Ất", "Bính", "Đinh", "Mậu", "Kỷ", "Canh", "Tân", "Nhâm", "Quý",
    ]
    public static let branches = [
        "Tý", "Sửu", "Dần", "Mão", "Thìn", "Tỵ", "Ngọ", "Mùi", "Thân", "Dậu", "Tuất", "Hợi",
    ]

    public init(stemIndex: Int, branchIndex: Int) {
        self.stemIndex = ((stemIndex % 10) + 10) % 10
        self.branchIndex = ((branchIndex % 12) + 12) % 12
    }

    public var stemName: String { Self.stems[stemIndex] }
    public var branchName: String { Self.branches[branchIndex] }
    public var name: String { stemName + " " + branchName }
}

public enum HistoryScope: String, Hashable, Sendable, Codable {
    case modern
    case retrospective
    case documentedException
}

public struct SolarTermOccurrence: Hashable, Sendable, Codable {
    public var name: String
    public var index: Int
    public var instantUTC: Date?
    public var containingCivilDate: CivilDate
    public var precision: SolarTermPrecision
    public var sourceVersion: String

    public init(
        name: String,
        index: Int,
        instantUTC: Date?,
        containingCivilDate: CivilDate,
        precision: SolarTermPrecision,
        sourceVersion: String
    ) {
        self.name = name
        self.index = index
        self.instantUTC = instantUTC
        self.containingCivilDate = containingCivilDate
        self.precision = precision
        self.sourceVersion = sourceVersion
    }
}

public enum SolarTermPrecision: String, Hashable, Sendable, Codable {
    case day
    case minute
}

public struct CalendarDay: Hashable, Sendable, Codable {
    public var civilDate: CivilDate
    public var displayTimeZone: TimeZoneIdentifier
    public var calendarRuleZone: TimeZoneIdentifier
    public var weekday: Int
    public var lunarDate: LunarDate
    public var canChi: CanChi
    public var solarTerm: SolarTermOccurrence?
    public var historyScope: HistoryScope
    public var occurrenceIDs: [String]
    public var engineVersion: String
    public var warnings: [String]

    public init(
        civilDate: CivilDate,
        displayTimeZone: TimeZoneIdentifier,
        calendarRuleZone: TimeZoneIdentifier,
        weekday: Int,
        lunarDate: LunarDate,
        canChi: CanChi,
        solarTerm: SolarTermOccurrence?,
        historyScope: HistoryScope,
        occurrenceIDs: [String],
        engineVersion: String,
        warnings: [String]
    ) {
        self.civilDate = civilDate
        self.displayTimeZone = displayTimeZone
        self.calendarRuleZone = calendarRuleZone
        self.weekday = weekday
        self.lunarDate = lunarDate
        self.canChi = canChi
        self.solarTerm = solarTerm
        self.historyScope = historyScope
        self.occurrenceIDs = occurrenceIDs
        self.engineVersion = engineVersion
        self.warnings = warnings
    }
}

public enum CalendarCoreError: Error, Equatable, Sendable {
    case outOfRange(CivilDate)
    case invalidLunarDate(LunarDate)
    case missingSource(String)
}
