import SwiftUI
import SwiftData
import CoreComponents

public struct FeatureChatRoomView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \ChatRoom.roomId, order: .reverse) var allChatRooms: [ChatRoom]

    public init() {}
    
    public var body: some View {
        VStack {
            ThreeSectionBar(
                left: { Image(systemName: "chevron.left") },
                center: { Text("Chat List") },
                right: { Image(systemName: "chevron.right") }
            )
            List(allChatRooms) { chat in
                if chat.hiddenDate == nil {
                    HStack(alignment: .center) {
                        Image(systemName: "person.circle")
                        VStack(alignment: .leading) {
                            HStack(spacing: 4) {
                                Text("@ \(chat.name)")
                                if chat.isNotificationoOff {
                                    Image(systemName: "speaker.slash")
                                }
                                Spacer()
                            }
                            if let latestMessage = chat.latestMessage {
                                Text(latestMessage)
                            }
                        }
                        Spacer()
                    }
                        .swipeActions {
                            Button(action: {
                                chat.hiddenDate = Date()
                                try? context.save()
                            }) {
                                Image(systemName: "eye.slash")
                            }
                                .tint(.indigo)
                            if chat.isNotificationoOff {
                                Button(action: {
                                    chat.isNotificationoOff = false
                                    try? context.save()
                                }) {
                                    Image(systemName: "speaker")
                                }
                                    .tint(.blue)
                            } else {
                                Button(action: {
                                    chat.isNotificationoOff = true
                                    try? context.save()
                                }) {
                                    Image(systemName: "speaker.slash")
                                }
                                    .tint(.gray)
                            }
                            
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                }

            }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
            Spacer()
            Button(action: {
                for chat in allChatRooms {
                    chat.hiddenDate = nil
                    chat.isNotificationoOff = false
                }
                try? context.save()
            }) {
                Text("Reset Settings")
            }
        }
            .frame(maxWidth: .infinity)
    }
}
