import SwiftUI
import FeatureChat
import FeatureChatViewer

struct ContentView: View {
    var body: some View {
        FeatureChatEntryView()
            .modelContainer(for: [
                ChatRoom.self
            ])
    }
}

#Preview {
    ContentView()
}
