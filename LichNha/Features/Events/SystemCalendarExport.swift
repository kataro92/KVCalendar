import EventKit
import EventKitUI
import SwiftUI
import CalendarCore

enum SystemCalendarExport {
    static func draftEvent(title: String, civil: CivilDate, in store: EKEventStore = EKEventStore()) -> EKEvent {
        let event = EKEvent(eventStore: store)
        event.title = title
        event.isAllDay = true
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh") ?? TimeZone(secondsFromGMT: 7 * 3600)!
        var parts = DateComponents()
        parts.year = civil.year
        parts.month = civil.month
        parts.day = civil.day
        let start = calendar.date(from: parts) ?? Date()
        event.startDate = start
        event.endDate = calendar.date(byAdding: .day, value: 1, to: start) ?? start
        event.notes = "Thêm từ Lịch Nhà. Không đọc lịch iPhone."
        return event
    }
}

struct SystemCalendarExportSheet: UIViewControllerRepresentable {
    var title: String
    var civil: CivilDate
    var onDismiss: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onDismiss: onDismiss)
    }

    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let store = EKEventStore()
        let controller = EKEventEditViewController()
        controller.eventStore = store
        controller.event = SystemCalendarExport.draftEvent(title: title, civil: civil, in: store)
        controller.editViewDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {}

    final class Coordinator: NSObject, EKEventEditViewDelegate {
        var onDismiss: () -> Void

        init(onDismiss: @escaping () -> Void) {
            self.onDismiss = onDismiss
        }

        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            onDismiss()
        }
    }
}
