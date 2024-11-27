import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab {
                SimpleAlertView()
            } label: {
                Text("Simple")
            }
            Tab {
                ParseIntAlertView()
            } label: {
                Text("Throw")
            }
            Tab {
                ParseIntResultAlertView()
            } label: {
                Text("Result")
            }
        }
    }
}

#Preview {
    ContentView()
}
