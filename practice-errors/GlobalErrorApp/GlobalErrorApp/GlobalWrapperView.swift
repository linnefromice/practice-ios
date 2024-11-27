import SwiftUI

struct GlobalWrapperView: View {
    @State var errState: ErrorState = ErrorState()
    
    var body: some View {
        VStack {
            WorkingView(errState: errState)
            Text("\(errState.error?.localizedDescription ?? "")")
        }
        .alert(
            "GlobalErrorAlert",
            isPresented: Binding(
                get: { errState.error != nil },
                // *1 or *2
                set: { if !$0 { errState.clearError() }} // *1
                // set: { if !$0 {}} // *2
            ),
            presenting: errState.error
        ) { error in
            Button("OK", role: .cancel) {
                // errState.clearError() // *2
            }
        }
    }
}

#Preview {
    GlobalWrapperView()
}
