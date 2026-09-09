import CryptoKit
import Foundation
import CalendarCore

struct GoldenFile: Codable {
    var schemaVersion: String
    var engineVersion: String
    var owner: String
    var generatedAt: String
    var recordsChecksum: String
    var records: [GoldenRecord]
}

struct GoldenRecord: Codable, Equatable {
    var civilYear: Int
    var civilMonth: Int
    var civilDay: Int
    var lunarYear: Int
    var lunarMonth: Int
    var lunarDay: Int
    var isLeapMonth: Bool
    var sourceKind: String
    var sourceNote: String
    var timezone: String
    var engineVersion: String
}

@main
enum GoldenCalendarBuilder {
    static func main() throws {
        var records: [GoldenRecord] = []
        records.append(contentsOf: publishedExamples())
        records.append(contentsOf: tetNewYears())
        records.append(contentsOf: try lunarMonthStarts())
        records.append(contentsOf: try leapMonthStarts())
        records.append(contentsOf: years1968To1975())
        records.append(contentsOf: publishedRangeAnchors())
        records.append(contentsOf: socNearMidnight())
        records.sort {
            CivilDate(year: $0.civilYear, month: $0.civilMonth, day: $0.civilDay)
                < CivilDate(year: $1.civilYear, month: $1.civilMonth, day: $1.civilDay)
        }
        records = unique(records)
        let checksum = try checksum(of: records)
        let file = GoldenFile(
            schemaVersion: "1",
            engineVersion: VietnameseLunarCalendar.ruleSetVersion,
            owner: "chủ dự án",
            generatedAt: "2026-09-09",
            recordsChecksum: checksum,
            records: records
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(file)
        let output = CommandLine.arguments.dropFirst().first
            ?? "LichNha/Tests/Fixtures/calendar-golden.json"
        let url = URL(fileURLWithPath: output)
        try FileManager.default.createDirectory(
            at: url.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )
        try data.write(to: url)
        FileHandle.standardError.write(
            Data("wrote \(records.count) records to \(url.path)\n".utf8)
        )
    }

    static func publishedExamples() -> [GoldenRecord] {
        [
            make(
                CivilDate(year: 1983, month: 12, day: 4),
                sourceKind: "published-example",
                sourceNote: "Hồ Ngọc Đức 2008: Sóc A trước Đông chí 1983, 4/12/1983"
            ),
            make(
                CivilDate(year: 1984, month: 2, day: 2),
                sourceKind: "published-example",
                sourceNote: "Hồ Ngọc Đức 2008: tháng Giêng 1984 bắt đầu 2/2/1984"
            ),
            make(
                CivilDate(year: 2004, month: 3, day: 21),
                sourceKind: "published-example",
                sourceNote: "Hồ Ngọc Đức 2008: tháng 2 nhuận 2004 bắt đầu 21/3/2004"
            ),
        ]
    }

    static func tetNewYears() -> [GoldenRecord] {
        let years = [
            1900, 1950, 1968, 1975, 1976, 1984, 2000, 2004, 2012, 2020, 2023, 2024, 2025, 2100,
        ]
        return years.compactMap { year in
            let lunar = LunarDate(
                day: 1,
                month: 1,
                year: year,
                isLeapMonth: false,
                ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
            )
            guard let civil = try? VietnameseLunarCalendar.civilDate(from: lunar),
                  civil.isInPublishedRange
            else { return nil }
            return make(
                civil,
                sourceKind: year <= 1975 ? "engine-self-historical" : "engine-self",
                sourceNote: "Tết, mùng 1 tháng Giêng \(year)"
            )
        }
    }

    static func lunarMonthStarts() throws -> [GoldenRecord] {
        var records: [GoldenRecord] = []
        for year in [2004, 2024] {
            for month in 1...12 {
                let lunar = LunarDate(
                    day: 1,
                    month: month,
                    year: year,
                    isLeapMonth: false,
                    ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
                )
                let civil = try VietnameseLunarCalendar.civilDate(from: lunar)
                records.append(
                    make(civil, sourceKind: "engine-self", sourceNote: "đầu tháng âm \(month)/\(year)")
                )
            }
        }
        return records
    }

    static func leapMonthStarts() throws -> [GoldenRecord] {
        var records: [GoldenRecord] = []
        for year in 1900...2100 {
            for month in 1...12 {
                let lunar = LunarDate(
                    day: 1,
                    month: month,
                    year: year,
                    isLeapMonth: true,
                    ruleSetVersion: VietnameseLunarCalendar.ruleSetVersion
                )
                if let civil = try? VietnameseLunarCalendar.civilDate(from: lunar) {
                    records.append(
                        make(
                            civil,
                            sourceKind: year <= 1975 ? "engine-self-historical" : "engine-self",
                            sourceNote: "đầu tháng \(month) nhuận \(year)"
                        )
                    )
                }
            }
        }
        return records
    }

    static func years1968To1975() -> [GoldenRecord] {
        var records: [GoldenRecord] = []
        for year in 1968...1975 {
            for month in 1...12 {
                records.append(
                    make(
                        CivilDate(year: year, month: month, day: 1),
                        sourceKind: "engine-self-historical",
                        sourceNote: "neo 1968–1975, ngày 1 dương"
                    )
                )
            }
            records.append(
                make(
                    CivilDate(year: year, month: 4, day: 30),
                    sourceKind: "engine-self-historical",
                    sourceNote: "neo 1968–1975, 30/4"
                )
            )
        }
        return records
    }

    static func publishedRangeAnchors() -> [GoldenRecord] {
        var dates: [CivilDate] = [
            CivilDate(year: 1900, month: 1, day: 1),
            CivilDate(year: 2100, month: 12, day: 31),
            CivilDate(year: 1976, month: 1, day: 1),
            CivilDate(year: 2020, month: 1, day: 25),
            CivilDate(year: 2023, month: 1, day: 22),
            CivilDate(year: 2024, month: 2, day: 10),
            CivilDate(year: 2025, month: 1, day: 29),
        ]
        for year in [1900, 1950, 1976, 2000, 2012, 2020, 2100] {
            for month in 1...12 {
                dates.append(CivilDate(year: year, month: month, day: 1))
            }
        }
        return dates.map {
            make($0, sourceKind: "engine-self", sourceNote: "neo 1900–2100, lich-nha-cal-1")
        }
    }

    static func socNearMidnight() -> [GoldenRecord] {
        let start = LunarNewMoon.k(containing: CivilDate(year: 1900, month: 1, day: 1))
        let end = LunarNewMoon.k(containing: CivilDate(year: 2100, month: 12, day: 31))
        var records: [GoldenRecord] = []
        for k in start...end {
            let hours = LunarNewMoon.hoursAfterLocalMidnight(k: k)
            guard hours < 0.5 || hours > 23.5 else { continue }
            let civil = LunarNewMoon.civilDate(k: k)
            guard civil.isInPublishedRange else { continue }
            let kind = civil.year <= 1975 ? "soc-near-midnight-historical" : "soc-near-midnight"
            records.append(
                make(
                    civil,
                    sourceKind: kind,
                    sourceNote: String(
                        format: "Sóc %.2f giờ sau nửa đêm UTC+7 (k=%d)",
                        hours,
                        k
                    )
                )
            )
        }
        return records
    }

    static func unique(_ records: [GoldenRecord]) -> [GoldenRecord] {
        var seen = Set<String>()
        var result: [GoldenRecord] = []
        for record in records {
            let key = "\(record.civilYear)-\(record.civilMonth)-\(record.civilDay)-\(record.sourceKind)"
            if seen.insert(key).inserted {
                result.append(record)
            }
        }
        return result
    }

    static func make(_ civil: CivilDate, sourceKind: String, sourceNote: String) -> GoldenRecord {
        let lunar = try! VietnameseLunarCalendar.lunarDate(from: civil)
        return GoldenRecord(
            civilYear: civil.year,
            civilMonth: civil.month,
            civilDay: civil.day,
            lunarYear: lunar.year,
            lunarMonth: lunar.month,
            lunarDay: lunar.day,
            isLeapMonth: lunar.isLeapMonth,
            sourceKind: sourceKind,
            sourceNote: sourceNote,
            timezone: "UTC+7",
            engineVersion: VietnameseLunarCalendar.ruleSetVersion
        )
    }

    static func checksum(of records: [GoldenRecord]) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let data = try encoder.encode(records)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
