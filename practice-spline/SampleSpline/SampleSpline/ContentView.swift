import SwiftUI
import SplineRuntime

struct ContentView: View {
    let splineFilenames: [String] = [
        "test_for_ios",
        "01_synesthesia",
        "02_anticipation",
        "03_deja_vu",
        "04_chil",
        "05_phantom",
        "06_nirvana",
        "07_flow",
        "01_synesthesia_Non-interactive",
        "02_anticipation_Non-interactive",
        "03_deja_vu_Non-interactive",
        "04_chill_Non-interactive",
        "05_phantom_Non-interactive",
        "06_nirvana_Non-interactive",
        "07_flow_Non-interactive"
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
