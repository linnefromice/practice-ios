import Foundation
import SwiftData

@Model
final class Team {
    var id: UUID
    var name: String
    var members: [UUID]

    init(id: UUID = UUID(), name: String, members: [UUID]) {
        self.id = id
        self.name = name
        self.members = members
    }
}
