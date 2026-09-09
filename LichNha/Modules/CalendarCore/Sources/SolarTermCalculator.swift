import Foundation

public enum SolarTermCalculator {
    public static let version = Astronomy.engineVersion

    public static let names = [
        "Xuân phân", "Thanh minh", "Cốc vũ", "Lập hạ",
        "Tiểu mãn", "Mang chủng", "Hạ chí", "Tiểu thử",
        "Đại thử", "Lập thu", "Xử thử", "Bạch lộ",
        "Thu phân", "Hàn lộ", "Sương giáng", "Lập đông",
        "Tiểu tuyết", "Đại tuyết", "Đông chí", "Tiểu hàn",
        "Đại hàn", "Lập xuân", "Vũ thủy", "Kinh trập",
    ]

    /// The 24 terms are 15° steps of apparent sun longitude. Index 0 = Xuân phân.
    public static func termStartingOn(_ civil: CivilDate) -> SolarTermOccurrence? {
        let jdn = Astronomy.julianDayNumber(day: civil.day, month: civil.month, year: civil.year)
        let today = longitudeIndex(jdn: jdn)
        let yesterday = longitudeIndex(jdn: jdn - 1)
        guard today != yesterday else { return nil }
        let name = names[today]
        return SolarTermOccurrence(
            name: name,
            index: today,
            instantUTC: nil,
            containingCivilDate: civil,
            precision: .day,
            sourceVersion: version
        )
    }

    static func longitudeIndex(jdn: Int) -> Int {
        let lon = Astronomy.sunLongitudeRadians(jdn: jdn)
        let deg = lon * 180 / Double.pi
        var idx = Int(floor(deg / 15)) % 24
        if idx < 0 { idx += 24 }
        return idx
    }
}
