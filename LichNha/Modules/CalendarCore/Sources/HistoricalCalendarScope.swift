import Foundation

public enum HistoricalCalendarScope {
    public static let warningID = "history-retrospective-pre-1976"
    public static let modernFromYear = 1976

    public static func scope(for civil: CivilDate) -> HistoryScope {
        if civil.year >= modernFromYear {
            return .modern
        }
        if civil.year >= 1968 && civil.year <= 1975 {
            return .documentedException
        }
        return .retrospective
    }

    public static func warningMessage(for civil: CivilDate) -> String? {
        switch scope(for: civil) {
        case .modern:
            return nil
        case .documentedException:
            return "Ngày âm giai đoạn 1968–1975 có thể khác giữa nguồn miền Bắc và miền Nam."
        case .retrospective:
            return "Lịch thiên văn hồi chiếu; không phải lịch pháp định thống nhất toàn quốc."
        }
    }
}
