import CalendarCore
import ContentCore

enum CalendarAccessibility {
    private static let weekdays = [
        "", "Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy",
    ]

    static func sheetSummary(
        day: CalendarDay,
        occurrences: [CalendarOccurrence],
        personalTitles: [String]
    ) -> String {
        let weekday = weekdays.indices.contains(day.weekday) ? weekdays[day.weekday] : ""
        let leap = day.lunarDate.isLeapMonth ? " nhuận" : ""
        var parts = [
            weekday,
            "ngày dương \(day.civilDate.day)",
            "Âm lịch \(day.lunarDate.day) tháng \(day.lunarDate.month)\(leap)",
        ]
        if let term = day.solarTerm {
            parts.append(term.name)
        }
        parts.append(contentsOf: occurrences.map(\.title))
        parts.append(contentsOf: personalTitles)
        return parts.joined(separator: ", ")
    }

    static func sceneDescription(cueID: String?) -> String? {
        switch cueID {
        case "cue-quoc-khanh":
            return "Không khí Quốc khánh: cờ Việt Nam trên khánh lịch và pháo hoa phía xa."
        case "cue-lap-xuan":
            return "Không khí Lập Xuân: nhành nhỏ trên mép tường, không phải dự báo thời tiết."
        default:
            return nil
        }
    }
}
