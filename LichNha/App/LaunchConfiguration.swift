import Foundation

enum LaunchConfiguration {
    static var arguments: [String] { ProcessInfo.processInfo.arguments }

    static var isUITesting: Bool {
        arguments.contains("--uitesting")
    }

    static var denyNotifications: Bool {
        arguments.contains("--deny-notifications")
            || (isUITesting && !arguments.contains("--allow-notifications"))
    }

    static var resetPersonalStore: Bool {
        arguments.contains("--reset-personal-store")
    }

    static var openURL: URL? {
        guard let flag = arguments.firstIndex(of: "--open-url"), arguments.indices.contains(flag + 1) else {
            return nil
        }
        return URL(string: arguments[flag + 1])
    }

    static var launchSurface: CalendarSurface? {
        guard let flag = arguments.firstIndex(of: "--screen"), arguments.indices.contains(flag + 1) else {
            return nil
        }
        switch arguments[flag + 1] {
        case "today": return .todayFront
        case "month": return .month
        case "detail": return .dayBack
        case "events": return .events
        case "editor": return .eventEditor
        case "settings": return .paperDrawer
        default: return nil
        }
    }
}
