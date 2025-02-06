import Foundation
import SwiftData

@Model
public final class ChatRoom {
    @Attribute(.unique) var roomId: Int
    var name: String
    var latestMessage: String?
    var isNotificationoOff: Bool
    var hiddenDate: Date?

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
