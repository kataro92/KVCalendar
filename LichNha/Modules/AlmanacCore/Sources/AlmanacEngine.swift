import Foundation
import CalendarCore

public enum AlmanacEngine {
    public static let referenceLabel = "tham khảo theo lịch truyền thống"
    public static let ruleset = AlmanacCatalog.version1

    /// Twelve earthly-branch hours, Tý starting at 23:00 local.
    public static let hourNames = StemBranch.branches

    public static let hoangGods = [
        "Thanh Long", "Minh Đường", "Thiên Hình", "Chu Tước",
        "Kim Quỹ", "Thiên Đức", "Bạch Hổ", "Ngọc Đường",
        "Thiên Lao", "Huyền Vũ", "Tư Mệnh", "Câu Trần",
    ]

    public static let hoangSet: Set<String> = [
        "Thanh Long", "Minh Đường", "Kim Quỹ", "Thiên Đức", "Ngọc Đường", "Tư Mệnh",
    ]

    public static let lucDieuPalaces = [
        "Đại An", "Lưu Niên", "Tốc Hỷ", "Xích Khẩu", "Tiểu Cát", "Không Vong",
    ]

    public static func entries(for day: CalendarDay) -> [AlmanacEntry] {
        var result: [AlmanacEntry] = []
        result.append(contentsOf: hoangHacDao(day))
        result.append(lucDieu(day))
        result.append(satChuThoTu(day))
        return result
    }

    public static func hoangHacDao(_ day: CalendarDay) -> [AlmanacEntry] {
        let dayBranch = day.canChi.day.branchIndex
        return (0..<12).map { hour in
            let god = hoangGods[(hour + dayBranch) % 12]
            let kind = hoangSet.contains(god) ? "Hoàng Đạo" : "Hắc Đạo"
            return AlmanacEntry(
                civilDate: day.civilDate,
                rulesetID: ruleset.id,
                methodID: "hoang-hac-dao",
                label: "Giờ \(hourNames[hour]): \(god) (\(kind))",
                isReferenceOnly: true
            )
        }
    }

    public static func lucDieu(_ day: CalendarDay) -> AlmanacEntry {
        let start = (day.lunarDate.month - 1) % 6
        let index = (start + day.lunarDate.day - 1) % 6
        let palace = lucDieuPalaces[index]
        return AlmanacEntry(
            civilDate: day.civilDate,
            rulesetID: ruleset.id,
            methodID: "luc-dieu",
            label: "Lục Diệu ngày: \(palace)",
            isReferenceOnly: true
        )
    }

    public static func satChuThoTu(_ day: CalendarDay) -> AlmanacEntry {
        AlmanacEntry(
            civilDate: day.civilDate,
            rulesetID: ruleset.id,
            methodID: "sat-chu-tho-tu",
            label: "Sát Chủ / Thọ Tử: chưa khóa ấn bản; không kết luận.",
            isReferenceOnly: true
        )
    }

    public static func fusedVerdict(from entries: [AlmanacEntry]) -> String? {
        _ = entries
        return nil
    }
}
