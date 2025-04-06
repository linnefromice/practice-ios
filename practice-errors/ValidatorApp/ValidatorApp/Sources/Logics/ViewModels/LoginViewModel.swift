import Foundation

class LoginViewModel: ObservableObject {
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessages: ErrorMessages = ErrorMessages()
    
    struct ErrorMessages {
        var userId: String? = nil
        var password: String? = nil
    }
    
    private let userIdValidator = CompositeValidator(validators: [
        AnyValidator(NonEmptyValidator()),
        AnyValidator(UserIdValidator())
    ])
    
    private let passwordValidator = CompositeValidator(validators: [
        AnyValidator(NonEmptyValidator())
    ])
    
    func validateForm() -> Bool {
        var hasError = false
        
        // ユーザーIDのバリデーション
        let userIdResult = userIdValidator.validate(userId)
        if case .failure(let error) = userIdResult {
            errorMessages.userId = error.errorDescription
            hasError = true
        } else {
            errorMessages.userId = nil
        }
        
        // パスワードのバリデーション
        let passwordResult = passwordValidator.validate(password)
        if case .failure(let error) = passwordResult {
            errorMessages.password = error.errorDescription
            hasError = true
        } else {
            errorMessages.password = nil
        }
        
        return !hasError
    }
    
    func login() {
        if validateForm() {
            isLoggedIn = true
        }
    }
} 