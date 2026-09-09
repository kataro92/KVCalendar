import Foundation
import CalendarCore
import ContentCore
import SwiftUI

enum AppRouter {
    static func today(in context: TimeContext) throws -> CalendarDay {
        let civil = context.today(in: context.displayZone)
        return try VietnameseLunarCalendar.calendarDay(
            civil: civil,
            displayTimeZone: context.displayZone,
            timeContext: context
        )
    }

    static func widgetDeepLink(civil: CivilDate) -> URL {
        URL(string: WidgetSnapshotBuilder.deepLink(civil: civil))!
    }

    static func todayRoot() -> some View {
        LichNhaRootView()
    }
}
