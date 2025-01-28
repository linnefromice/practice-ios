import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            // ScrollView {
                SwipableListView()
            // }
                .frame(maxWidth: .infinity)
            Button(action: {}) {
                Text("Add")
            }
                .buttonStyle(.bordered)
                .frame(width: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
