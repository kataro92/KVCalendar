import Foundation
import CalendarCore

enum MonthRouter {
    static func civil(fromDeepLink url: URL) -> CivilDate? {
        // lichnha://day/2026-09-02
        guard url.scheme == "lichnha" else { return nil }
        let parts = url.path.split(separator: "/").filter { !$0.isEmpty }
        let stamp = parts.last.map(String.init) ?? url.host
        guard let stamp else { return nil }
        let numbers = stamp.split(separator: "-").compactMap { Int($0) }
        guard numbers.count == 3 else { return nil }
        let civil = CivilDate(year: numbers[0], month: numbers[1], day: numbers[2])
        return civil.isInPublishedRange ? civil : nil
    }
}
