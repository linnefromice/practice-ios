import SwiftUI
import CoreComponents
import CoreDesignSystem

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
            VStack {
                Text("Primary")
                    .foregroundStyle(Color._primary)
                Text("On Primary")
                    .foregroundStyle(Color._onPrimary)
                Text("Info")
                    .foregroundStyle(Color._info)
            }
            .background(.gray)
            .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
