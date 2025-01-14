import SwiftUI

// ref: https://developer.apple.com/documentation/swiftui/draggesture
public struct DragGestureCircle: View {
  @State private var isDragging = false
  @State private var offsetX: CGFloat = 0
  @State private var offsetY: CGFloat = 0

  var drag: some Gesture {
    DragGesture()
      .onChanged { value in
        self.isDragging = true
        self.offsetX = value.translation.width
        self.offsetY = value.translation.height
      }
      .onEnded { _ in
        self.isDragging = false
        // self.offsetX = 0
        // self.offsetY = 0
      }
  }

  public var body: some View {
    ZStack {
      Circle()
        .fill(isDragging ? .red : .blue)
        .frame(width: 100, height: 100)
        .offset(x: offsetX, y: offsetY)
        .gesture(drag)
    }
  }
}

#Preview {
  DragGestureCircle()
}
