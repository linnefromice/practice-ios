import SwiftUI
import SplineRuntime

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

            ForEach(splineFilenames, id: \.self) { filename in
                Tab("Raw: \(filename)", systemImage: "globe.desk") {
                    let url = Bundle.main.url(forResource: filename, withExtension: "splineswift")!
                    SplineView(sceneFileURL: url)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
