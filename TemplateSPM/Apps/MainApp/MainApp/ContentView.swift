import SwiftUI
import CoreComponents

struct ContentView: View {
    var body: some View {
        VStack {
            ThreeSectionBar(
                left: { Image(systemName: "chevron.left") },
                center: { Text("Title") },
                right: { Image(systemName: "chevron.right") }
            )
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
