import SwiftUI
import SplineRuntime

public struct SplineRenderingView: View {
    let resourceName: String

    public init(resourceName: String) {
        self.resourceName = resourceName
    }

    public var body: some View {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "splineswift")!
        SplineView(sceneFileURL: url).ignoresSafeArea(.all)
            // .onTapGesture {
            //     // タップ時のアクション
            //     print("Spline tapped")
            // }
    }
}
