import SwiftUI
import RiveRuntime

struct RiveLoading: View {
    var body: some View {
        RiveViewModel(fileName: "loading").view()
    }
}

#Preview {
    VStack(spacing: 24) {
        RiveLoading()
        RiveLoading()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray)
            )
    }
}

