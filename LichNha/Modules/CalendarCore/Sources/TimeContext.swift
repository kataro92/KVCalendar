import Foundation

/// Gregorian civil date without time, offset, or time zone.
public struct CivilDate: Hashable, Sendable, Comparable, Codable {
    public var year: Int
    public var month: Int
    public var day: Int

    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }

    public static func < (lhs: CivilDate, rhs: CivilDate) -> Bool {
        if lhs.year != rhs.year { return lhs.year < rhs.year }
        if lhs.month != rhs.month { return lhs.month < rhs.month }
        return lhs.day < rhs.day
    }

    public var isInPublishedRange: Bool {
        year >= 1900 && year <= 2100
    }

    public func adding(days: Int) -> CivilDate {
        let jdn = Astronomy.julianDayNumber(day: day, month: month, year: year) + days
        return Astronomy.civilDate(fromJulianDayNumber: jdn)
    }
}

/// IANA zone identifier used as a value type so modules stay off UIKit/SwiftUI.
public struct TimeZoneIdentifier: Hashable, Sendable, Codable {
    public var rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public static let vietnam = TimeZoneIdentifier("Asia/Ho_Chi_Minh")
}

/// Three clocks that must not be collapsed: calendar rules, on-screen "today", reminder delivery.
public struct TimeContext: Sendable {
    public var calendarRuleZone: TimeZoneIdentifier
    public var displayZone: TimeZoneIdentifier
    public var deliveryZone: TimeZoneIdentifier
    public var now: @Sendable () -> Date

    public init(
        calendarRuleZone: TimeZoneIdentifier = .vietnam,
        displayZone: TimeZoneIdentifier,
        deliveryZone: TimeZoneIdentifier,
        now: @escaping @Sendable () -> Date = { Date() }
    ) {
        self.calendarRuleZone = calendarRuleZone
        self.displayZone = displayZone
        self.deliveryZone = deliveryZone
        self.now = now
    }

    public func today(in zone: TimeZoneIdentifier) -> CivilDate {
        let tz = TimeZone(identifier: zone.rawValue) ?? TimeZone(secondsFromGMT: 7 * 3600)!
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = tz
        let parts = calendar.dateComponents([.year, .month, .day], from: now())
        return CivilDate(year: parts.year!, month: parts.month!, day: parts.day!)
    }
}
