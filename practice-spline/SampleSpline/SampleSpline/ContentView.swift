import SwiftUI

struct ContentView: View {
    let splineFilenames: [String] = [
        "01_synesthesia",
        "02_anticipation",
        "03_deja_vu",
        "04_chil",
        "05_phantom",
        "06_nirvana",
        "07_flow"
    ]
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                    .padding()
            }
            ForEach(splineFilenames, id: \.self) { filename in
                Tab(filename, systemImage: "globe") {
                    SplineRenderingView(resourceName: filename)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
