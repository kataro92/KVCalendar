import Foundation
import EffectCore
#if canImport(UIKit)
import UIKit
#endif

enum CapabilityPolicy {
    static func snapshot(reduceMotion: Bool, dimFlashingLights: Bool) -> EffectCapabilitySnapshot {
        #if canImport(UIKit)
        let thermal = ProcessInfo.processInfo.thermalState
        let severe = thermal == .serious || thermal == .critical
        let lowPower = ProcessInfo.processInfo.isLowPowerModeEnabled
        #else
        let severe = false
        let lowPower = false
        #endif
        return EffectCapabilitySnapshot(
            lowPower: lowPower,
            thermalSevere: severe,
            reduceMotion: reduceMotion,
            dimFlashingLights: dimFlashingLights
        )
    }
}
