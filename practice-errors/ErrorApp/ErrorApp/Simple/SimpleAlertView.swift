import SwiftUI

struct SimpleAlertView: View {
    @State var error: GenericError?
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Button("Trigger Error") {
                error = .global
                showAlert = true
            }
        }
        .padding()
        .alert(isPresented: $showAlert, error: error) { _ in
            Button("OK") {
                showAlert = false
            }
        } message: { err in
            // EmptyView()
            Text(error?.localizedDescription ?? "Unknown Error")
        }
    }
}

#Preview {
    SimpleAlertView()
}
