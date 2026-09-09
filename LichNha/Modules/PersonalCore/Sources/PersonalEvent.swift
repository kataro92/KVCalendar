import Foundation
import CalendarCore

public struct PersonalEvent: Hashable, Sendable, Codable, Identifiable {
    public var id: String
    public var title: String
    public var notes: String?
    public var calendarBasis: EventCalendarBasis
    public var originCivilDate: CivilDate?
    public var originLunarDate: LunarDate?
    public var recurrence: Recurrence
    public var leapMonthPolicy: LeapMonthPolicy
    public var shortMonthPolicy: ShortMonthPolicy
    public var reminderPolicy: ReminderPolicy
    public var calculationZone: TimeZoneIdentifier
    public var deliveryZone: TimeZoneIdentifier
    public var dstResolutionPolicy: DSTResolutionPolicy
    public var widgetPrivacy: WidgetPrivacy
    public var createdAt: Date
    public var updatedAt: Date

    public var reminderEnabled: Bool { reminderPolicy.enabled }

    public init(
        id: String,
        title: String,
        notes: String? = nil,
        calendarBasis: EventCalendarBasis,
        originCivilDate: CivilDate? = nil,
        originLunarDate: LunarDate? = nil,
        recurrence: Recurrence,
        leapMonthPolicy: LeapMonthPolicy = .regularMonth,
        shortMonthPolicy: ShortMonthPolicy = .lastDayOfMonth,
        reminderPolicy: ReminderPolicy = ReminderPolicy(),
        calculationZone: TimeZoneIdentifier = .vietnam,
        deliveryZone: TimeZoneIdentifier = .vietnam,
        dstResolutionPolicy: DSTResolutionPolicy = .gapNextValidOverlapEarlier,
        widgetPrivacy: WidgetPrivacy = .hidden,
        createdAt: Date = Date(timeIntervalSince1970: 0),
        updatedAt: Date = Date(timeIntervalSince1970: 0)
    ) {
        self.id = id
        self.title = title
        self.notes = notes
        self.calendarBasis = calendarBasis
        self.originCivilDate = originCivilDate
        self.originLunarDate = originLunarDate
        self.recurrence = recurrence
        self.leapMonthPolicy = leapMonthPolicy
        self.shortMonthPolicy = shortMonthPolicy
        self.reminderPolicy = reminderPolicy
        self.calculationZone = calculationZone
        self.deliveryZone = deliveryZone
        self.dstResolutionPolicy = dstResolutionPolicy
        self.widgetPrivacy = widgetPrivacy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

public struct ReminderPolicy: Hashable, Sendable, Codable {
    public var enabled: Bool
    public var leadDays: Int
    public var hour: Int
    public var minute: Int

    public init(enabled: Bool = true, leadDays: Int = 3, hour: Int = 8, minute: Int = 0) {
        self.enabled = enabled
        self.leadDays = leadDays
        self.hour = hour
        self.minute = minute
    }
}

public enum EventCalendarBasis: String, Hashable, Sendable, Codable {
    case solar
    case lunar
}

public enum Recurrence: String, Hashable, Sendable, Codable {
    case none
    case yearly
}

public enum LeapMonthPolicy: String, Hashable, Sendable, Codable, CaseIterable {
    case regularMonth
    case leapMonth
    case both
    case substitute
}

public enum ShortMonthPolicy: String, Hashable, Sendable, Codable, CaseIterable {
    case lastDayOfMonth
    case skip
    case firstOfNext
}

public enum DSTResolutionPolicy: String, Hashable, Sendable, Codable {
    case gapNextValidOverlapEarlier
}

public enum WidgetPrivacy: String, Hashable, Sendable, Codable {
    case publicTitle
    case genericMarker
    case hidden
}

public enum PersonalEventCopy {
    public static let lunarMonthNames = [
        1: "Giêng", 2: "Hai", 3: "Ba", 4: "Tư", 5: "Năm", 6: "Sáu",
        7: "Bảy", 8: "Tám", 9: "Chín", 10: "Mười", 11: "Mười Một", 12: "Chạp",
    ]

    public static func lunarMonthName(_ month: Int) -> String {
        lunarMonthNames[month] ?? "\(month)"
    }

    public static func policySummary(_ event: PersonalEvent) -> String {
        var parts: [String] = []
        switch event.calendarBasis {
        case .lunar:
            if let lunar = event.originLunarDate {
                let leapOrigin = lunar.isLeapMonth ? " nhuận" : ""
                let loop = event.recurrence == .yearly ? " hằng năm" : " một lần"
                parts.append(
                    "Nhắc ngày \(lunar.day) tháng \(lunarMonthName(lunar.month)) âm lịch\(leapOrigin)\(loop)."
                )
                parts.append(leapPolicySentence(event.leapMonthPolicy, month: lunar.month))
                if lunar.day == 30 {
                    parts.append(shortMonthSentence(event.shortMonthPolicy))
                }
            }
        case .solar:
            if let civil = event.originCivilDate {
                let loop = event.recurrence == .yearly ? " hằng năm" : " một lần"
                parts.append("Nhắc ngày \(civil.day) tháng \(civil.month) dương lịch\(loop).")
            }
        }
        if event.reminderPolicy.enabled {
            let minute = String(format: "%02d", event.reminderPolicy.minute)
            if event.reminderPolicy.leadDays == 0 {
                parts.append("Nhắc đúng ngày lúc \(event.reminderPolicy.hour):\(minute).")
            } else {
                parts.append(
                    "Nhắc trước \(event.reminderPolicy.leadDays) ngày lúc \(event.reminderPolicy.hour):\(minute)."
                )
            }
        } else {
            parts.append("Không bật lời nhắc.")
        }
        parts.append("Ngày âm theo lịch Việt UTC+7. Giờ nhắc theo múi giờ đã chọn.")
        return parts.joined(separator: " ")
    }

    public static func leapPolicySentence(_ policy: LeapMonthPolicy, month: Int) -> String {
        let name = lunarMonthName(month)
        switch policy {
        case .regularMonth:
            return "Chỉ tháng \(name) thường, không nhắc tháng nhuận."
        case .leapMonth:
            return "Chỉ nhắc tháng \(name) nhuận; năm không nhuận tháng này thì bỏ."
        case .both:
            return "Nhắc cả tháng \(name) thường và tháng \(name) nhuận khi năm có nhuận."
        case .substitute:
            return "Năm có tháng \(name) nhuận thì nhắc tháng nhuận; năm không nhuận thì dùng tháng thường."
        }
    }

    public static func shortMonthSentence(_ policy: ShortMonthPolicy) -> String {
        switch policy {
        case .lastDayOfMonth:
            return "Nếu tháng chỉ có 29 ngày, nhắc ngày cuối tháng."
        case .skip:
            return "Nếu tháng chỉ có 29 ngày, bỏ năm đó."
        case .firstOfNext:
            return "Nếu tháng chỉ có 29 ngày, nhắc mùng 1 tháng sau."
        }
    }
}
