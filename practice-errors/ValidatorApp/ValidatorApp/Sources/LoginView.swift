import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ログイン")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("ユーザーID")
                    .font(.headline)
                TextField("ユーザーIDを入力", text: $viewModel.userId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if let error = viewModel.errorMessages.userId {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Text("パスワード")
                    .font(.headline)
                SecureField("パスワードを入力", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if let error = viewModel.errorMessages.password {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding(.horizontal)
            
            Button(action: {
                viewModel.login()
            }) {
                Text("ログイン")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
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
