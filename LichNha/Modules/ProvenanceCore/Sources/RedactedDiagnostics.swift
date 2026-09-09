import Foundation

public enum RedactedDiagnostics {
    public static let forbiddenKeys = ["title", "notes", "eventTitle"]

    public static func isSafeLogPayload(_ payload: [String: String]) -> Bool {
        !payload.keys.contains { key in
            forbiddenKeys.contains(key.lowercased())
        }
    }

    public static func redacted(_ message: String) -> String {
        _ = message
        return "calendar-event"
    }

    public static func containsUserContent(_ text: String, title: String, notes: String?) -> Bool {
        if text.localizedCaseInsensitiveContains(title) { return true }
        if let notes, !notes.isEmpty, text.localizedCaseInsensitiveContains(notes) { return true }
        return false
    }
}
