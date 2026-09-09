import Foundation
import CalendarCore
import ContentCore

enum WidgetSnapshotBuilder {
    static func build(
        day: CalendarDay,
        publicTitles: [String],
        personal: [WidgetPersonalInput],
        now: Date = Date(),
        displayZone: TimeZoneIdentifier = .vietnam
    ) -> WidgetSnapshot {
        ContentCore.WidgetSnapshotBuilder.build(
            day: day,
            publicTitles: publicTitles,
            personal: personal,
            now: now,
            displayZone: displayZone
        )
    }
}
