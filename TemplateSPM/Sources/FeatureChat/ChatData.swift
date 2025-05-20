import Foundation
import SwiftData

@Model
public final class ChatRoom {
    @Attribute(.unique) public var roomId: Int
    public var name: String
    public var latestMessage: String?
    public var isNotificationoOff: Bool
    public var hiddenDate: Date?

    public init(
        roomId: Int,
        name: String,
        latestMessage: String? = nil,
        isNotificationoOff: Bool = false,
        hiddenDate: Date? = nil
    ) {
        self.roomId = roomId
        self.name = name
        self.latestMessage = latestMessage
        self.isNotificationoOff = isNotificationoOff
        self.hiddenDate = hiddenDate
    }
}
