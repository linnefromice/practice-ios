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
  @Environment(\.signUpState) var viewModel: SignUpViewModel
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
  @Environment(\.signUpState) var viewModel: SignUpViewModel
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
  @Environment(\.signUpState) var viewModel: SignUpViewModel
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
  @Environment(\.signUpState) var viewModel: SignUpViewModel
  @Binding var navPath: [SignUpDestination]

  var body: some View {
    Text("Home")
    Text("\(viewModel.values())")
  }
}

struct NavigationRoot: View {
    @State var navPath: [SignUpDestination] = []

    var body: some View {
      NavigationStack(path: $navPath) {
        SignUpEmailView(navPath: $navPath)
          .navigationDestination(for: SignUpDestination.self) { dest in
            switch dest {
            case .email:
              SignUpEmailView(navPath: $navPath)
            case .password:
              SignUpPasswordView(navPath: $navPath)
            case .codeVerification:
              SignUpCodeVerificationView(navPath: $navPath)
            case .home:
              HomeView(navPath: $navPath)
            }
          }
      }
    }
}


struct SignUpStateKey: EnvironmentKey {
    static let defaultValue: SignUpViewModel = SignUpViewModel()
}

extension EnvironmentValues {
    var signUpState: SignUpViewModel {
        get { self[SignUpStateKey.self] }
        set { self[SignUpStateKey.self] = newValue }
    }
}

struct ContentView: View {
  @State var navPath: [SignUpDestination] = []
  @State var viewModel: SignUpViewModel = SignUpViewModel()

  var body: some View {
      NavigationRoot(navPath: navPath)
          .environment(\.signUpState, viewModel)
  }
}

#Preview {
  ContentView(viewModel: .init())
}
