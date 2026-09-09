import Foundation
import CalendarCore
import ProvenanceCore

public enum OccurrenceTaxonomy: String, Hashable, Sendable, Codable {
    case statutoryHoliday
    case yearlySchedule
    case commemoration
    case traditionalLunar
    case localFestival
    case personal

    public var displayName: String {
        switch self {
        case .statutoryHoliday: "Ngày nghỉ theo luật"
        case .yearlySchedule: "Lịch năm"
        case .commemoration: "Ngày kỷ niệm"
        case .traditionalLunar: "Lễ truyền thống (tham khảo)"
        case .localFestival: "Lễ hội địa phương"
        case .personal: "Sự kiện riêng"
        }
    }
}

public struct CalendarOccurrence: Hashable, Sendable, Codable {
    public var id: String
    public var title: String
    public var taxonomy: OccurrenceTaxonomy
    public var calendarBasis: String
    public var sourceID: String?
    public var packVersion: String
    public var isDayOff: Bool
    public var legalCitation: String?
    public var solarYear: Int?
    public var solarMonth: Int?
    public var solarDay: Int?
    public var lunarMonth: Int?
    public var lunarDay: Int?
    public var lunarIsLeap: Bool?
    public var region: String?
    public var audience: String?

    public init(
        id: String,
        title: String,
        taxonomy: OccurrenceTaxonomy,
        calendarBasis: String,
        sourceID: String? = nil,
        packVersion: String,
        isDayOff: Bool = false,
        legalCitation: String? = nil,
        solarYear: Int? = nil,
        solarMonth: Int? = nil,
        solarDay: Int? = nil,
        lunarMonth: Int? = nil,
        lunarDay: Int? = nil,
        lunarIsLeap: Bool? = nil,
        region: String? = nil,
        audience: String? = nil
    ) {
        self.id = id
        self.title = title
        self.taxonomy = taxonomy
        self.calendarBasis = calendarBasis
        self.sourceID = sourceID
        self.packVersion = packVersion
        self.isDayOff = isDayOff
        self.legalCitation = legalCitation
        self.solarYear = solarYear
        self.solarMonth = solarMonth
        self.solarDay = solarDay
        self.lunarMonth = lunarMonth
        self.lunarDay = lunarDay
        self.lunarIsLeap = lunarIsLeap
        self.region = region
        self.audience = audience
    }

    public func matches(day: CalendarDay) -> Bool {
        switch calendarBasis {
        case "solar":
            guard let solarMonth, let solarDay else { return false }
            if let solarYear, day.civilDate.year != solarYear { return false }
            return day.civilDate.month == solarMonth && day.civilDate.day == solarDay
        case "lunar":
            guard let lunarMonth, let lunarDay else { return false }
            if day.lunarDate.month != lunarMonth || day.lunarDate.day != lunarDay {
                return false
            }
            if let lunarIsLeap {
                return day.lunarDate.isLeapMonth == lunarIsLeap
            }
            return !day.lunarDate.isLeapMonth
        default:
            return false
        }
    }
}

public struct SourceRecord: Hashable, Sendable, Codable {
    public var id: String
    public var title: String
    public var url: String?
    public var evidenceTier: EvidenceTier
    public var publisher: String?
    public var accessedAt: String
    public var scope: String
    public var licenseStatus: LicenseStatus
    public var contentHash: String
}

public enum EvidenceTier: String, Hashable, Sendable, Codable {
    case computed
    case official
    case cultural
    case traditional
    case personal

    public var displayName: String {
        switch self {
        case .computed: "Tính toán"
        case .official: "Văn bản chính thức"
        case .cultural: "Văn hóa"
        case .traditional: "Truyền thống"
        case .personal: "Cá nhân"
        }
    }
}

public enum LicenseStatus: String, Hashable, Sendable, Codable {
    case publicRecord
    case publicDomain
    case licensed
    case original
    case restricted
}

public struct ContentPack: Hashable, Sendable, Codable {
    public var schemaVersion: String
    public var packVersion: String
    public var publishedAt: String
    public var effectiveRange: EffectiveRange
    public var minimumAppVersion: String
    public var recordsChecksum: String
    public var approvals: [String]
    public var sources: [SourceRecord]
    public var occurrences: [CalendarOccurrence]
    public var almanac: AlmanacPackSection?

    public struct EffectiveRange: Hashable, Sendable, Codable {
        public var from: Int
        public var to: Int
    }

    public struct AlmanacPackSection: Hashable, Sendable, Codable {
        public var rulesetId: String
        public var version: String
        public var methods: [AlmanacPackMethod]
    }

    public struct AlmanacPackMethod: Hashable, Sendable, Codable {
        public var id: String
        public var displayName: String?
    }
}

public struct ContentManifest: Hashable, Sendable, Codable {
    public var packs: [Item]

    public struct Item: Hashable, Sendable, Codable {
        public var id: String
        public var file: String
        public var kind: String
    }
}
