import SwiftData

@Model
public class ChatRoom {
    @Attribute(.unique) var roomId: String
    var name: String
    var latestMessage: String?

    public init(
        roomId: String,
        name: String,
        latestMessage: String? = nil
    ) {
        self.roomId = roomId
        self.name = name
        self.latestMessage = latestMessage
    }
}
