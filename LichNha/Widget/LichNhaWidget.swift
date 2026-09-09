import WidgetKit
import SwiftUI
import ContentCore

struct LichNhaWidget: Widget {
    static let kind = "LichNhaToday"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: Self.kind, provider: WidgetTimelineProvider()) { entry in
            LichNhaWidgetView(entry: entry)
        }
        .configurationDisplayName("Lịch Nhà")
        .description("Tờ hôm nay, không cần mạng.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular, .accessoryInline])
        .contentMarginsDisabled()
    }
}

struct LichNhaWidgetView: View {
    var entry: LichNhaEntry
    @Environment(\.widgetFamily) private var family
    @Environment(\.redactionReasons) private var redaction

    var body: some View {
        let lockScreen = isLockScreen
        WidgetBlocView(
            snapshot: entry.snapshot,
            isToday: entry.isToday,
            lockScreen: lockScreen,
            compact: family == .accessoryInline || family == .accessoryRectangular
        )
        .padding(family == .systemMedium ? 16 : 12)
        .containerBackground(for: .widget) {
            DesignTokens.paper
        }
        .widgetURL(URL(string: entry.snapshot.deepLink))
        .privacySensitive(lockScreen)
    }

    private var isLockScreen: Bool {
        switch family {
        case .accessoryCircular, .accessoryRectangular, .accessoryInline:
            return true
        default:
            return redaction.contains(.privacy)
        }
    }
}

@main
struct LichNhaWidgetBundle: WidgetBundle {
    var body: some Widget {
        LichNhaWidget()
    }
}
