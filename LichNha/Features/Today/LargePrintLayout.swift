import SwiftUI

enum LargePrintLayout {
    static func showsSecondaryOnFront(_ size: DynamicTypeSize) -> Bool {
        size < .accessibility2
    }

    static func solarDayPointSize(_ size: DynamicTypeSize) -> CGFloat {
        if size >= .accessibility3 { return 48 }
        if size >= .accessibility2 { return 56 }
        return 72
    }
}
