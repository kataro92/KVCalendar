import Foundation
import CalendarCore
import Observation

@MainActor
@Observable
final class TodayViewModel {
    var selectedDate: CivilDate
    var day: CalendarDay?
    var loadError: String?
    let timeContext: TimeContext

    init(timeContext: TimeContext = TimeContext(displayZone: .vietnam, deliveryZone: .vietnam)) {
        self.timeContext = timeContext
        self.selectedDate = timeContext.today(in: timeContext.displayZone)
        refresh()
    }

    var isViewingToday: Bool {
        selectedDate == timeContext.today(in: timeContext.displayZone)
    }

    func goToToday() {
        selectedDate = timeContext.today(in: timeContext.displayZone)
        refresh()
    }

    func goToNextDay() {
        shift(days: 1)
    }

    func goToPreviousDay() {
        shift(days: -1)
    }

    func shift(days: Int) {
        let next = selectedDate.adding(days: days)
        guard next.isInPublishedRange else { return }
        selectedDate = next
        refresh()
    }

    func refresh() {
        do {
            day = try VietnameseLunarCalendar.calendarDay(
                civil: selectedDate,
                displayTimeZone: timeContext.displayZone,
                timeContext: timeContext
            )
            loadError = nil
        } catch {
            day = nil
            loadError = "Không tính được ngày này."
        }
    }
}
