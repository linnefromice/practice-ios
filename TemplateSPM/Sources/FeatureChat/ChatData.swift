import SwiftData

@Model
public class ChatRoom {
    @Attribute(.unique) var roomId: Int
    var name: String
    var latestMessage: String?

    public init(
        roomId: Int,
        name: String,
        latestMessage: String? = nil
    ) {
        self.roomId = roomId
        self.name = name
        self.latestMessage = latestMessage
    }
}
