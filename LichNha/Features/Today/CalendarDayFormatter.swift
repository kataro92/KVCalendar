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

    static func solarMonthYear(_ day: CalendarDay) -> String {
        "Tháng \(day.civilDate.month) năm \(day.civilDate.year)"
    }

    static func lunar(_ day: CalendarDay) -> String {
        let leap = day.lunarDate.isLeapMonth ? " nhuận" : ""
        return "Âm lịch \(day.lunarDate.day) tháng \(day.lunarDate.month)\(leap)"
    }

    static func canChiDay(_ day: CalendarDay) -> String {
        day.canChi.day.name
    }
}
