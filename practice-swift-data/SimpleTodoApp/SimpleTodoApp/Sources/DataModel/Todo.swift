import Foundation
import SwiftData

@Model
final class Todo {
    var id: UUID
    var title: String
    var assigneeIds: [UUID]
    var createdAt: Date

    init(id: UUID = UUID(), title: String, assigneeIds: [UUID], createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.assigneeIds = assigneeIds
        self.createdAt = createdAt
    }
}
