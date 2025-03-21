import SwiftUI

struct DebugView: View {
    @State private var value: String = ""
    @State private var errorMessage: String = ""
    @State private var showSuccessDialog: Bool = false
    @State private var showErrorDialog: Bool = false
    @State private var validationError: String? = nil

    private let remoteCallService: RemoteCallService

    init(remoteCallService: RemoteCallService) {
        self.remoteCallService = remoteCallService
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter error message", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            if let validationError = validationError {
                Text(validationError)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }

            HStack(spacing: 10) {
                Button("Success") {
                    Task {
                        await handleRemoteCall(isSuccess: true)
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(minWidth: 100)

                Button("Validation Error") {
                    Task {
                        await handleRemoteCall(isSuccess: false, errorMessage: "Validation Error")
                    }
                }
                .buttonStyle(.bordered)
                .frame(minWidth: 100)

                Button("Global Error") {
                    Task {
                        await handleRemoteCall(isSuccess: false)
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                .frame(minWidth: 100)
            }
            .padding()
        }
        .padding()
        .alert("Success", isPresented: $showSuccessDialog) {
            Button("OK") {}
        } message: {
            Text("Operation completed successfully")
        }
        .alert("Error", isPresented: $showErrorDialog) {
            Button("OK") {}
        } message: {
            Text("A global error occurred")
        }
    }

    private func handleRemoteCall(
        isSuccess: Bool,
        errorMessage: String? = nil
    ) async {
        let result = await remoteCallService.call(
            isSuccess: isSuccess, errorMessage: errorMessage ?? "")

        await MainActor.run {
            // 前回のバリデーションエラーをリセット
            validationError = nil

            switch result {
            case .success:
                showSuccessDialog = true
            case .validationError(let message):
                validationError = message
            case .globalError:
                showErrorDialog = true
            }
        }
    }
}

#Preview {
    DebugView(remoteCallService: RemoteCallService())
}
