import SwiftUI
import CalendarCore

@main
struct LichNhaApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouter.todayRoot()
        }
    }
}
