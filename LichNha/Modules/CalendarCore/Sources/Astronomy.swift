import Foundation

/// Julian day, Sóc, and Trung khí for lịch Việt UTC+7.
///
/// Rules (Hồ Ngọc Đức, 2008): day 1 contains the new moon; month 11 contains
/// winter solstice; leap month is the first month after that solstice with no
/// major solar term; calculations use 105°E / UTC+7. Formulas below are the
/// published simplified set. Version `lich-nha-cal-1`.
enum Astronomy {
    static let engineVersion = "lich-nha-cal-1"
    static let vietnamOffsetHours = 7.0
    private static let pi = Double.pi
    static let synodicMonth = 29.530588853
    static let epochJD = 2_415_021.076998695

    static func julianDayNumber(day: Int, month: Int, year: Int) -> Int {
        let a = (14 - month) / 12
        let y = year + 4800 - a
        let m = month + 12 * a - 3
        var jd = day + (153 * m + 2) / 5 + 365 * y + y / 4 - y / 100 + y / 400 - 32045
        if jd < 2_299_161 {
            jd = day + (153 * m + 2) / 5 + 365 * y + y / 4 - 32083
        }
        return jd
    }

    static func civilDate(fromJulianDayNumber jd: Int) -> CivilDate {
        let a: Int
        let b: Int
        let c: Int
        if jd > 2_299_160 {
            a = jd + 32044
            b = (4 * a + 3) / 146097
            c = a - (b * 146097) / 4
        } else {
            b = 0
            c = jd + 32082
        }
        let d = (4 * c + 3) / 1461
        let e = c - (1461 * d) / 4
        let m = (5 * e + 2) / 153
        let day = e - (153 * m + 2) / 5 + 1
        let month = m + 3 - 12 * (m / 10)
        let year = b * 100 + d - 4800 + m / 10
        return CivilDate(year: year, month: month, day: day)
    }

    static func newMoonJulianDate(k: Int, offsetHours: Double = vietnamOffsetHours) -> Double {
        let t = Double(k) / 1236.85
        let t2 = t * t
        let t3 = t2 * t
        let dr = pi / 180
        var jd1 = 2_415_020.75933 + 29.53058868 * Double(k) + 0.0001178 * t2 - 0.000000155 * t3
        jd1 += 0.00033 * sin((166.56 + 132.87 * t - 0.009173 * t2) * dr)
        let m = 359.2242 + 29.10535608 * Double(k) - 0.0000333 * t2 - 0.00000347 * t3
        let mpr = 306.0253 + 385.81691806 * Double(k) + 0.0107306 * t2 + 0.00001236 * t3
        let f = 21.2964 + 390.67050646 * Double(k) - 0.0016528 * t2 - 0.00000239 * t3
        var c1 = (0.1734 - 0.000393 * t) * sin(m * dr) + 0.0021 * sin(2 * dr * m)
        c1 = c1 - 0.4068 * sin(mpr * dr) + 0.0161 * sin(dr * 2 * mpr)
        c1 = c1 - 0.0004 * sin(dr * 3 * mpr)
        c1 = c1 + 0.0104 * sin(dr * 2 * f) - 0.0051 * sin(dr * (m + mpr))
        c1 = c1 - 0.0074 * sin(dr * (m - mpr)) + 0.0004 * sin(dr * (2 * f + m))
        c1 = c1 - 0.0004 * sin(dr * (2 * f - m)) - 0.0006 * sin(dr * (2 * f + mpr))
        c1 = c1 + 0.0010 * sin(dr * (2 * f - mpr)) + 0.0005 * sin(dr * (2 * mpr + m))
        let deltaT: Double
        if t < -11 {
            deltaT =
                0.001 + 0.000839 * t + 0.0002261 * t2 - 0.00000845 * t3 - 0.000000081 * t * t3
        } else {
            deltaT = -0.000278 + 0.000265 * t + 0.000262 * t2
        }
        return jd1 + c1 - deltaT
    }

    static func newMoonDay(k: Int, offsetHours: Double = vietnamOffsetHours) -> Int {
        Int(floor(newMoonJulianDate(k: k, offsetHours: offsetHours) + 0.5 + offsetHours / 24))
    }

    /// Major solar term 0...11 at local midnight of `jdn` (0 = after Xuân phân).
    static func majorSolarTerm(jdn: Int, offsetHours: Double = vietnamOffsetHours) -> Int {
        Int(floor(sunLongitudeRadians(jdn: jdn, offsetHours: offsetHours) / pi * 6))
    }

    static func sunLongitudeRadians(jdn: Int, offsetHours: Double = vietnamOffsetHours) -> Double {
        let t = (Double(jdn) - 2_451_545.5 - offsetHours / 24) / 36525
        let t2 = t * t
        let dr = pi / 180
        let m = 357.52910 + 35999.05030 * t - 0.0001559 * t2 - 0.00000048 * t * t2
        let l0 = 280.46645 + 36000.76983 * t + 0.0003032 * t2
        var dl = (1.914600 - 0.004817 * t - 0.000014 * t2) * sin(dr * m)
        dl += (0.019993 - 0.000101 * t) * sin(dr * 2 * m) + 0.000290 * sin(dr * 3 * m)
        var l = (l0 + dl) * dr
        l -= pi * 2 * floor(l / (pi * 2))
        return l
    }

    static func kFromDayNumber(_ dayNumber: Int) -> Int {
        Int(floor((Double(dayNumber) - epochJD) / synodicMonth))
    }
}
