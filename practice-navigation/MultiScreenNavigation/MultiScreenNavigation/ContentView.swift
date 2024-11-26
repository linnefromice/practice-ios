import SwiftUI

enum SignUpDestination {
    case email
    case password
    case codeVerification
    case home
}

@Observable
class SignUpViewModel {
    var email: String?
    var password: String?
    var code: String?
    
    func values() -> [String?] {
        [email, password, code]
    }
    
    func updateEmail(_ email: String) {
        self.email = email
    }
    func updatePassword(_ password: String) {
        self.password = password
    }
    func updateCode(_ code: String) {
        self.code = code
    }
}

struct SignUpEmailView: View {
    var viewModel: SignUpViewModel
    @State var email: String = ""
    @Binding var navPath: [SignUpDestination]

    var body: some View {
        Text("Email")
        Text("\(viewModel.values())")
        TextField("Email", text: $email)
            .onChange(of: email) { newValue in
                viewModel.updateEmail(newValue)
            }
        Button("Next") {
            navPath.append(.password)
        }
    }
}

struct SignUpPasswordView: View {
    var viewModel: SignUpViewModel
    @State var password: String = ""
    @Binding var navPath: [SignUpDestination]

    var body: some View {
        Text("Password")
        Text("\(viewModel.values())")
        TextField("Password", text: $password)
            .onChange(of: password) { newValue in
                viewModel.updatePassword(newValue)
            }
        Button("Next") {
            navPath.append(.codeVerification)
        }
    }
}

struct SignUpCodeVerificationView: View {
    var viewModel: SignUpViewModel
    @State var code: String = ""
    @Binding var navPath: [SignUpDestination]

    var body: some View {
        Text("CodeVerification")
        Text("\(viewModel.values())")
        TextField("Code", text: $code)
            .onChange(of: code) { newValue in
                viewModel.updateCode(newValue)
            }
        Button("Next") {
            navPath.append(.home)
        }
    }
}

struct HomeView: View {
    var viewModel: SignUpViewModel
    @Binding var navPath: [SignUpDestination]

    var body: some View {
        Text("Home")
        Text("\(viewModel.values())")
    }
}

struct ContentView: View {
    @State var navPath: [SignUpDestination] = []
    let viewModel: SignUpViewModel
    
    var body: some View {
        NavigationStack(path: $navPath) {
            SignUpEmailView(viewModel: viewModel, navPath: $navPath)
                .navigationDestination(for: SignUpDestination.self) { dest in
                    switch dest {
                    case .email:
                        SignUpEmailView(viewModel: viewModel, navPath: $navPath)
                    case .password:
                        SignUpPasswordView(viewModel: viewModel, navPath: $navPath)
                    case .codeVerification:
                        SignUpCodeVerificationView(viewModel: viewModel, navPath: $navPath)
                    case .home:
                        HomeView(viewModel: viewModel, navPath: $navPath)
                    }
                }
//            .onAppear {
//                navPath.append(.email)
//            }
        }
    }
}

#Preview {
    ContentView(viewModel: .init())
}
