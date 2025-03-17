import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            Button(title: "Tap me", action: {
                print("Button tapped")
            })
            .frame(width: 200, height: 50)
            .fixedSize()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
