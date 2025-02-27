import Foundation
import SwiftData


// enum AssigneeVariant: Codable {
//     case solo(UUID)
//     case multiple([UUID])

//     var variantName: String {
//         switch self {
//         case .solo:
//             return "SOLO"
//         case .multiple:
//             return "MULTIPLE"
//         }
//     }
// }


@Model
final class Todo {
    var id: UUID
    var title: String
    var assigneeIds: [UUID]
    // var assigneeIds: AssigneeVariant
    var createdAt: Date

    init(id: UUID = UUID(), title: String, assigneeIds: [UUID], createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.assigneeIds = assigneeIds
        self.createdAt = createdAt
    }
}
