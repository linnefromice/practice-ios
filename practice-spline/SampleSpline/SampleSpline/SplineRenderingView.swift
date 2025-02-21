import SwiftUI
import SplineRuntime

public struct SplineRenderingView: View {
    let resourceName: String

    @State private var isCardVisible = false

    public init(resourceName: String) {
        self.resourceName = resourceName
    }

    private func onTouchSpline() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                isCardVisible = true
            }
        }
    }

    public var body: some View {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "splineswift")!

        ZStack {
            SplineView(sceneFileURL: url).ignoresSafeArea(.all)
                .onTapGesture {
                    onTouchSpline()
                }
                // .gesture(DragGesture()
                //     .onEnded { _ in
                //         onTouchSpline()
                //     }
                // )
            
            if isCardVisible {
                // 背景を半透明にする場合は、必要に応じてオーバーレイ
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .ignoresSafeArea()
                    .transition(.opacity)

                CardView()
                    .transition(.scale)
            }
        }
    }
}


struct CardView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .stroke(Color.white, lineWidth: 8)
                    .frame(width: 280, height: 280)
                    .background(Color.clear)
                VStack {
                    Text("let's Jamming")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("3 people in the room")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            Rectangle()
                .fill(Color.white)
                .frame(width: 280, height: 120)
                .background(Color.clear)
        }
        .cornerRadius(8)
    }
}
