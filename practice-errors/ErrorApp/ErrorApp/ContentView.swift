import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab {
                SimpleAlertView()
            } label: {
                Text("Simple")
            }
        }
    }
}

#Preview {
    ContentView()
}
