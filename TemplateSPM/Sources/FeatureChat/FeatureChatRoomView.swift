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
                HStack(alignment: .center) {
                    Image(systemName: "person.circle")
                    VStack(alignment: .leading) {
                        Text("@ \(chat.name)")
                        if let latestMessage = chat.latestMessage {
                            Text(latestMessage)
                        }
                    }
                    Spacer()
                }
                    .swipeActions {
                        Button(action: {}) {
                            Image(systemName: "eye.slash")
                        }
                            .tint(.indigo)
                        Button(action: {}) {
                            Image(systemName: "speaker.slash")
                        }
                            .tint(.gray)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
            }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
        }
            .frame(maxWidth: .infinity)
    }
}
