import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EntryView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            DebugView(remoteCallService: RemoteCallService())
                .tabItem {
                    Label("Debug", systemImage: "ladybug")
                }
        }
    }
}

#Preview {
    ContentView()
}
