import Foundation
import CalendarCore

enum CalendarDayFormatter {
    static let weekdays = [
        "", "Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy",
    ]

    static func weekday(_ day: CalendarDay) -> String {
        let index = day.weekday
        guard weekdays.indices.contains(index) else { return "" }
        return weekdays[index]
    }

    static func solarDay(_ day: CalendarDay) -> String {
        "\(day.civilDate.day)"
    }

    static let solarMonthWords = [
        "", "Một", "Hai", "Ba", "Tư", "Năm", "Sáu", "Bảy", "Tám", "Chín", "Mười", "Mười Một", "Mười Hai",
    ]

    static func solarMonthYear(_ day: CalendarDay) -> String {
        "Tháng \(day.civilDate.month) năm \(day.civilDate.year)"
    }

    static func solarMonthHeadline(_ day: CalendarDay) -> String {
        let word = solarMonthWords.indices.contains(day.civilDate.month)
            ? solarMonthWords[day.civilDate.month]
            : "\(day.civilDate.month)"
        return "Tháng \(word)".uppercased(with: Locale(identifier: "vi_VN"))
    }

    static func headerMonthYear(_ day: CalendarDay) -> String {
        "Tháng \(day.civilDate.month) · \(day.civilDate.year)"
    }

    static func weekdayAndYear(_ day: CalendarDay) -> String {
        "\(weekday(day))  ·  \(day.civilDate.year)"
    }

    static func lunar(_ day: CalendarDay) -> String {
        let leap = day.lunarDate.isLeapMonth ? " nhuận" : ""
        return "Âm lịch \(day.lunarDate.day) tháng \(day.lunarDate.month)\(leap)"
    }

    static func lunarFront(_ day: CalendarDay) -> String {
        let leap = day.lunarDate.isLeapMonth ? " nhuận" : ""
        return "Âm lịch · \(day.lunarDate.day) tháng \(day.lunarDate.month)\(leap)"
    }

    static func canChiDay(_ day: CalendarDay) -> String {
        day.canChi.day.name
    }
}
