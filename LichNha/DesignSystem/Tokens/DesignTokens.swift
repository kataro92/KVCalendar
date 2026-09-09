import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

enum DesignTokens {
    static let paper = adaptive(
        light: (0.976, 0.957, 0.922),
        dark: (0.780, 0.706, 0.647)
    )
    static let ink = Color(red: 0.239, green: 0.169, blue: 0.141)
    static let inkSecondary = Color(red: 0.427, green: 0.361, blue: 0.361)
    static let son = Color(red: 0.722, green: 0.227, blue: 0.271)
    static let sonDeep = Color(red: 0.486, green: 0.188, blue: 0.251)
    static let khanh = Color(red: 0.545, green: 0.184, blue: 0.184)
    static let peach = Color(red: 0.973, green: 0.847, blue: 0.812)
    static let jade = Color(red: 0.776, green: 0.871, blue: 0.835)
    static let sky = Color(red: 0.788, green: 0.882, blue: 0.925)
    static let wood = Color(red: 0.420, green: 0.310, blue: 0.275)
    static let woodLight = Color(red: 0.820, green: 0.705, blue: 0.525)
    static let bronze = Color(red: 0.780, green: 0.604, blue: 0.345)
    static let bronzeLight = Color(red: 0.910, green: 0.780, blue: 0.490)
    static let bronzeDeep = Color(red: 0.520, green: 0.360, blue: 0.160)
    static let wall = adaptive(
        light: (0.941, 0.910, 0.855),
        dark: (0.220, 0.165, 0.255)
    )
    static let chromeInk = adaptive(
        light: (0.200, 0.169, 0.169),
        dark: (0.965, 0.945, 0.910)
    )
    static let chipFill = adaptive(
        light: (1.0, 0.973, 0.910),
        dark: (0.290, 0.220, 0.310)
    )

    static let spaceSM: CGFloat = 8
    static let spaceMD: CGFloat = 16
    static let spaceLG: CGFloat = 24
    static let radiusSheet: CGFloat = 16
    static let radiusChip: CGFloat = 22
    static let minHitTarget: CGFloat = 44
    static let motionFast: Double = 0.18
    static let motionPage: Double = 0.42
    static let blocWidthRatio: CGFloat = 0.70
    static let brassSize: CGFloat = 18
    static let headerHeight: CGFloat = 56
    static let headerRail: CGFloat = 8
    static let headerOverlap: CGFloat = 50

    private static func adaptive(
        light: (CGFloat, CGFloat, CGFloat),
        dark: (CGFloat, CGFloat, CGFloat)
    ) -> Color {
        #if canImport(UIKit)
        Color(
            uiColor: UIColor { trait in
                let value = trait.userInterfaceStyle == .dark ? dark : light
                return UIColor(red: value.0, green: value.1, blue: value.2, alpha: 1)
            }
        )
        #else
        Color(red: light.0, green: light.1, blue: light.2)
        #endif
    }
}
