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
                    .foregroundStyle(AppTheme.primary)
                Text("On Primary")
                    .foregroundStyle(AppTheme.onPrimary)
                Text("Info")
                    .foregroundStyle(AppTheme.info)
            }
            .background(.gray)
            .padding()
            HStack {
                Button("Dark") {
                    changeTheme(to: .dark)
                }
                Button("Light") {
                    changeTheme(to: .light)
                }
                Button("System") {
                    changeTheme(to: .unspecified)
                }
            }
            Spacer()
        }
        .padding()
    }

    private func changeTheme(to: UIUserInterfaceStyle) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.overrideUserInterfaceStyle = to
    }
    
}

#Preview {
    ContentView()
}
