import SwiftUI
import SwiftData

public struct FeatureChatEntryView: View {
    public init() {}
    
    public var body: some View {
        FeatureChatEntryContentsView()
            .modelContainer(for: [
                ChatRoom.self
            ])
    }
}

public struct FeatureChatEntryContentsView: View {
    @Environment(\.modelContext) private var context

    public init() {}

    public var body: some View {
        FeatureChatRoomView()
            .onAppear {
                resetData()
            }
    }

    private func resetData() {
        do {
            try context.delete(model: ChatRoom.self)
            let rooms: [ChatRoom] = [
                .init(roomId: "1", name: "John Doe", latestMessage: "Hello, how are you?"),
                .init(roomId: "2", name: "Jane Smith"),
                .init(roomId: "3", name: "Alice Johnson", latestMessage: "See you later!"),
                .init(roomId: "4", name: "Bob Brown", latestMessage: "Goodbye!"),
                .init(roomId: "5", name: "Charlie Davis", latestMessage: "What's going on?"),
                .init(roomId: "6", name: "David Lee", latestMessage: "I'm busy right now."),
                .init(roomId: "7", name: "Eve White", latestMessage: "Can we meet tomorrow?"),
                .init(roomId: "8", name: "Frank Green", latestMessage: "I'm available now."),
                .init(roomId: "9", name: "George Black", latestMessage: "Let's catch up soon."),
                .init(roomId: "10", name: "Helen Blue", latestMessage: "I'll be in the office tomorrow."),
                .init(roomId: "11", name: "Ian Yellow", latestMessage: "I'm running late."),
                .init(roomId: "12", name: "Mike Green", latestMessage: "Hello, how are you?"),
                .init(roomId: "13", name: "John Doe"),
                .init(roomId: "14", name: "Jane Smith", latestMessage: "What's up?"),
                .init(roomId: "15", name: "Alice Johnson", latestMessage: "See you later!"),
                .init(roomId: "16", name: "Bob Brown", latestMessage: "Goodbye!"),
                .init(roomId: "17", name: "Charlie Davis"),
                .init(roomId: "18", name: "David Lee"),
            ]
            for item in rooms {
                context.insert(item)
            }
            try context.save()
        } catch {
            print("Failed to reset data: \(error)")
        }
    }
}
