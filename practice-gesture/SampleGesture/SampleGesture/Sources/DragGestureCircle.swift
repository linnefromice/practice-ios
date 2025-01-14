import SwiftUI

public struct DragGestureCircle: View {
    @State private var isDragging = false

    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in self.isDragging = true }
            .onEnded { _ in self.isDragging = false }
    }

    public var body: some View {
        Circle()
            .fill(isDragging ? .red : .blue)
            .frame(width: 100, height: 100)
            .gesture(drag)
    }
}

#Preview {
    DragGestureCircle()
}
