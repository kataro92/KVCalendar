import SwiftUI

struct LichNhaAccessibilityState {
    var reduceMotion: Bool
    var increaseContrast: Bool
    var dimFlashingLights: Bool
    var dynamicTypeSize: DynamicTypeSize

    static let `default` = LichNhaAccessibilityState(
        reduceMotion: false,
        increaseContrast: false,
        dimFlashingLights: false,
        dynamicTypeSize: .large
    )
}

struct MinimumHitTarget: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: DesignTokens.minHitTarget, minHeight: DesignTokens.minHitTarget)
            .contentShape(Rectangle())
    }
}

extension View {
    func lichNhaHitTarget() -> some View {
        modifier(MinimumHitTarget())
    }
}

extension EnvironmentValues {
    var lichNhaDimFlashingLights: Bool {
        if #available(iOS 18.0, *) {
            accessibilityDimFlashingLights
        } else {
            false
        }
    }
}
