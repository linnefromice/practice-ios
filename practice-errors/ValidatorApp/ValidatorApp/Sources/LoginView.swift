import SwiftUI

struct LoginView: View {
    @State private var userId: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var userIdError: String? = nil
    @State private var passwordError: String? = nil
    
    private let userIdValidator = CompositeValidator(validators: [
        AnyValidator(NonEmptyValidator()),
        AnyValidator(UserIdValidator())
    ])
    
    private let passwordValidator = CompositeValidator(validators: [
        AnyValidator(NonEmptyValidator())
    ])
    
    private func validateForm() -> Bool {
        var hasError = false
        // ユーザーIDのバリデーション
        let userIdResult = userIdValidator.validate(userId)
        if case .failure(let error) = userIdResult {
            userIdError = error.errorDescription
            hasError = true
        } else {
            userIdError = nil
        }
        
        // パスワードのバリデーション
        let passwordResult = passwordValidator.validate(password)
        if case .failure(let error) = passwordResult {
            passwordError = error.errorDescription
            hasError = true
        } else {
            passwordError = nil
        }
        
        return !hasError
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ログイン")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("ユーザーID")
                    .font(.headline)
                TextField("ユーザーIDを入力", text: $userId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if let error = userIdError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Text("パスワード")
                    .font(.headline)
                SecureField("パスワードを入力", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if let error = passwordError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding(.horizontal)
            
            Button(action: {
                if validateForm() {
                    isLoggedIn = true
                }
            }) {
                Text("ログイン")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                DashboardView()
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
