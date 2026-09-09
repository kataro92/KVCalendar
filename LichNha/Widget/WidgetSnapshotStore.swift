import Foundation
import ContentCore
import WidgetKit

enum WidgetSnapshotStore {
    static func save(_ file: WidgetSnapshotFile) {
        try? ContentCore.WidgetSnapshotStore.saveToSharedContainer(file)
        WidgetCenter.shared.reloadTimelines(ofKind: LichNhaWidget.kind)
    }

    static func load() -> WidgetSnapshotFile? {
        ContentCore.WidgetSnapshotStore.loadFromSharedContainer()
    }
}
