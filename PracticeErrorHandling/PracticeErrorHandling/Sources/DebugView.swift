import SwiftUI

struct DebugView: View {
    @State private var errorMessage: String = ""
    @State private var showSuccessDialog: Bool = false
    @State private var showErrorDialog: Bool = false
    @State private var validationError: String? = nil
    
    private let remoteCallService = RemoteCallService()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("エラーメッセージを入力", text: $errorMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if let validationError = validationError {
                Text(validationError)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
            
            HStack(spacing: 10) {
                Button("成功") {
                    Task {
                        await handleRemoteCall(isSuccess: true, errorMessage: "")
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("バリデーションエラー") {
                    Task {
                        await handleRemoteCall(isSuccess: false, errorMessage: errorMessage)
                    }
                }
                .buttonStyle(.bordered)
                .disabled(errorMessage.isEmpty)
                
                Button("グローバルエラー") {
                    Task {
                        await handleRemoteCall(isSuccess: false, errorMessage: "")
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
            }
            .padding()
        }
        .padding()
        .alert("成功", isPresented: $showSuccessDialog) {
            Button("OK") {}
        } message: {
            Text("操作が正常に完了しました")
        }
        .alert("エラー", isPresented: $showErrorDialog) {
            Button("OK") {}
        } message: {
            Text("グローバルエラーが発生しました")
        }
    }
    
    private func handleRemoteCall(isSuccess: Bool, errorMessage: String) async {
        let errorMessageArgs = errorMessage.isEmpty ? "Something went wrong" : errorMessage
        let result = await remoteCallService.call(isSuccess: isSuccess, errorMessage: errorMessageArgs)
        
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
    DebugView()
}
