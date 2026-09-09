import Foundation
import CalendarCore

struct MonthCell: Hashable, Sendable {
    var civil: CivilDate
    var isInMonth: Bool
    var isSelectable: Bool
    var lunarDay: Int
    var lunarMonth: Int
    var isLeapMonth: Bool
    var markers: [MonthMarker]
}

enum MonthMarker: String, Hashable, Sendable {
    case statutory
    case traditional
    case solarTerm
    case historical
}

enum MonthGridModel {
    static let weekdayLabels = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"]
    static let weekdaySpokenNames = [
        "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy", "Chủ Nhật",
    ]

    static func cells(
        year: Int,
        month: Int,
        markersForDay: ((CalendarDay) -> [MonthMarker])? = nil
    ) throws -> [MonthCell] {
        let first = CivilDate(year: year, month: month, day: 1)
        let weekday = try weekdayMondayIndex(first)
        var cells: [MonthCell] = []
        for index in 0..<42 {
            let civil = first.adding(days: index - weekday)
            let inMonth = civil.month == month && civil.year == year
            guard civil.isInPublishedRange else {
                cells.append(
                    MonthCell(
                        civil: civil,
                        isInMonth: false,
                        isSelectable: false,
                        lunarDay: 0,
                        lunarMonth: 0,
                        isLeapMonth: false,
                        markers: []
                    )
                )
                continue
            }
            let day = try VietnameseLunarCalendar.calendarDay(
                civil: civil,
                displayTimeZone: .vietnam
            )
            var markers = markersForDay?(day) ?? []
            if day.solarTerm != nil {
                markers.append(.solarTerm)
            }
            if day.historyScope != .modern {
                markers.append(.historical)
            }
            cells.append(
                MonthCell(
                    civil: civil,
                    isInMonth: inMonth,
                    isSelectable: true,
                    lunarDay: day.lunarDate.day,
                    lunarMonth: day.lunarDate.month,
                    isLeapMonth: day.lunarDate.isLeapMonth,
                    markers: Array(Set(markers)).sorted { $0.rawValue < $1.rawValue }
                )
            )
        }
        return cells
    }

    static func title(year: Int, month: Int) -> String {
        "Tháng \(month) năm \(year)"
    }

    static func shortLunar(_ cell: MonthCell) -> String {
        guard cell.isSelectable else { return "" }
        if cell.lunarDay == 1 {
            let leap = cell.isLeapMonth ? "N" : ""
            return "\(leap)\(cell.lunarMonth)/1"
        }
        return "\(cell.lunarDay)"
    }

    private static func weekdayMondayIndex(_ civil: CivilDate) throws -> Int {
        let day = try VietnameseLunarCalendar.calendarDay(
            civil: civil,
            displayTimeZone: .vietnam
        )
        return (day.weekday + 5) % 7
    }
}
