public struct ChatRoomData: Identifiable, Hashable, Sendable {
    let roomId: String
    let name: String
    let latestMessage: String?

    public init(
        roomId: String,
        name: String,
        latestMessage: String? = nil
    ) {
        self.roomId = roomId
        self.name = name
        self.latestMessage = latestMessage
    }

    public var id: String { roomId }
}
