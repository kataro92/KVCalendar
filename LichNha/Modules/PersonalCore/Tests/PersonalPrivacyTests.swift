import Foundation
import Testing
import ProvenanceCore
import PersonalCore
import CalendarCore

struct PersonalPrivacyTests {
    @Test func payloadWithTitleIsRejected() {
        #expect(RedactedDiagnostics.isSafeLogPayload(["title": "giỗ"]) == false)
        #expect(RedactedDiagnostics.isSafeLogPayload(["eventId": "1"]) == true)
    }

    @Test func storeErrorsDoNotEmbedTitleOrNotes() {
        let title = "Giỗ ông Nội ở Hà Nội"
        let notes = "ghi chú tuyệt mật"
        let missing = String(describing: PersonalStoreError.eventNotFound("sample"))
        let save = String(describing: PersonalStoreError.saveFailed)
        #expect(RedactedDiagnostics.containsUserContent(missing, title: title, notes: notes) == false)
        #expect(RedactedDiagnostics.containsUserContent(save, title: title, notes: notes) == false)
        #expect(RedactedDiagnostics.redacted(title) == "calendar-event")
    }

    @Test func policySummaryMayNameTheDateButLogsMustNotCopyTitle() {
        let event = PersonalEvent(
            id: "priv",
            title: "Tên riêng không được log",
            notes: "ghi chú riêng",
            calendarBasis: .lunar,
            originLunarDate: LunarDate(
                day: 12,
                month: 8,
                year: 2024,
                isLeapMonth: false,
                ruleSetVersion: "lich-nha-cal-1"
            ),
            recurrence: .yearly
        )
        let summary = PersonalEventCopy.policySummary(event)
        #expect(summary.contains("tháng Tám"))
        #expect(!summary.contains(event.title))
        #expect(!RedactedDiagnostics.isSafeLogPayload(["notes": event.notes ?? ""]))
    }
}
