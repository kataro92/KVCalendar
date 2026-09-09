import Foundation
import CalendarCore

struct AppEnvironment {
    var timeContext: TimeContext

    static var live: AppEnvironment {
        AppEnvironment(
            timeContext: TimeContext(
                displayZone: .vietnam,
                deliveryZone: .vietnam
            )
        )
    }
}
