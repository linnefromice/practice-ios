import SwiftUI

enum SignUpDestination {
    case email(EmailViewModel)
    case password(PasswordViewModel)
    case codeVerification(CodeVerificationViewModel)
}

@Observable
class EmailViewModel {
    var email: String?
}
struct SignUpEmailView: View {
    var body: some View {
        Text("Email")
    }
}

@Observable
class PasswordViewModel {
    var password: String?
}
struct SignUpPasswordView: View {
    var body: some View {
        Text("Password")
    }
}

@Observable
class CodeVerificationViewModel {
    var code: String?
}
struct SignUpCodeVerificationView: View {
    var body: some View {
        Text("CodeVerification")
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
