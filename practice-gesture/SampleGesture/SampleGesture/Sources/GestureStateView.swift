import SwiftUI

// ref: https://developer.apple.com/documentation/swiftui/gesturestate
public struct GestureStateView: View {
    @GestureState private var isDetectingLongPress = false

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 2.0)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }

    public var body: some View {
        Circle()
            .fill(self.isDetectingLongPress ? .red : .green)
            .frame(width: 100, height: 100)
            .gesture(longPress)
    }
}


#Preview {
    GestureStateView()
}
