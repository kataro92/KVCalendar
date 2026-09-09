import Foundation
import CalendarCore

public struct AlmanacRuleSet: Hashable, Sendable, Codable {
    public var id: String
    public var displayName: String
    public var version: String
    public var owner: String
    public var methods: [AlmanacMethod]
    public var isEnabledByDefault: Bool
}

public struct AlmanacMethod: Hashable, Sendable, Codable {
    public var id: String
    public var displayName: String
    public var sourceIDs: [String]
}

public struct AlmanacEntry: Hashable, Sendable, Codable {
    public var civilDate: CivilDate
    public var rulesetID: String
    public var methodID: String
    public var label: String
    public var isReferenceOnly: Bool
}

public enum AlmanacCatalog {
    public static let version1 = AlmanacRuleSet(
        id: "lich-nha-truyen-thong-1",
        displayName: "Lịch truyền thống 1.0",
        version: "1.0.0-draft",
        owner: "chủ dự án",
        methods: [
            AlmanacMethod(
                id: "hoang-hac-dao",
                displayName: "Giờ Hoàng Đạo / Hắc Đạo",
                sourceIDs: ["xieji-bianfang-shu"]
            ),
            AlmanacMethod(
                id: "luc-dieu",
                displayName: "Lục Diệu (dân gian)",
                sourceIDs: ["xiao-liuren-folk"]
            ),
            AlmanacMethod(
                id: "sat-chu-tho-tu",
                displayName: "Sát Chủ / Thọ Tử",
                sourceIDs: ["xieji-bianfang-shu"]
            ),
        ],
        isEnabledByDefault: true
    )
}
