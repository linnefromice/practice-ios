import SwiftUI
import SplineRuntime

struct Spline01View: View {
    var body: some View {
        let url = Bundle.main.url(forResource: "01_synesthesia", withExtension: "splineswift")!
        SplineView(sceneFileURL: url).ignoresSafeArea(.all)
    }
}
