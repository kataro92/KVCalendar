import Foundation
import SwiftData

public enum PersonalStoreError: Error, Equatable, Sendable {
    case eventNotFound(String)
    case saveFailed
}

@MainActor
public final class PersonalEventRepository {
    private let container: ModelContainer

    public init(container: ModelContainer) {
        self.container = container
    }

    public func allEvents() throws -> [PersonalEvent] {
        let context = ModelContext(container)
        var descriptor = FetchDescriptor<PersonalEventRecord>(sortBy: [SortDescriptor(\.updatedAt, order: .reverse)])
        descriptor.fetchLimit = 500
        return try context.fetch(descriptor).map { $0.asPersonalEvent() }
    }

    public func event(id: String) throws -> PersonalEvent? {
        try record(id: id, in: ModelContext(container))?.asPersonalEvent()
    }

    public func upsert(_ event: PersonalEvent) throws {
        let context = ModelContext(container)
        if let existing = try record(id: event.id, in: context) {
            existing.apply(event)
        } else {
            context.insert(PersonalEventRecord(event: event))
        }
        do {
            try context.save()
        } catch {
            throw PersonalStoreError.saveFailed
        }
    }

    public func delete(id: String) throws {
        let context = ModelContext(container)
        guard let existing = try record(id: id, in: context) else {
            throw PersonalStoreError.eventNotFound(id)
        }
        context.delete(existing)
        do {
            try context.save()
        } catch {
            throw PersonalStoreError.saveFailed
        }
    }

    public func deleteAll() throws {
        let context = ModelContext(container)
        let records = try context.fetch(FetchDescriptor<PersonalEventRecord>())
        for record in records {
            context.delete(record)
        }
        try context.save()
    }

    private func record(id: String, in context: ModelContext) throws -> PersonalEventRecord? {
        var descriptor = FetchDescriptor<PersonalEventRecord>(
            predicate: #Predicate { $0.id == id }
        )
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }
}

extension PersonalStoreError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .eventNotFound:
            return "personal-event-missing"
        case .saveFailed:
            return "personal-store-save-failed"
        }
    }
}
