import SwiftUI

struct LoginView: View {
    @State private var userId: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    
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
                
                Text("パスワード")
                    .font(.headline)
                SecureField("パスワードを入力", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            
            Button(action: {
                // ログイン処理
                isLoggedIn = true
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
