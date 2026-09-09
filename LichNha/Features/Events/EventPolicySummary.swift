import PersonalCore

enum EventPolicySummary {
    static func text(_ event: PersonalEvent) -> String {
        PersonalEventCopy.policySummary(event)
    }
}
