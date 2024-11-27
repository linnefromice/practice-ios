import SwiftUI

struct WorkingView: View {
    let errState: ErrorState
    
    var body: some View {
        VStack {
            Text("Global")
            Button("Set Error") {
                errState.setError(GlobalError.invalid)
            }
        }
    }
}

#Preview {
    @Previewable let errState = ErrorState()
    VStack {
        WorkingView(errState: errState)
        Text("\(errState.error?.localizedDescription ?? "Nothing")")
    }
}
