import Foundation

public struct UserIdValidator: Validator {
    public init() {}
    
    public func validate(_ value: String) -> ValidationResult {
        // 半角アルファベット（大文字小文字）とハイフンのみを許可する正規表現
        let regex = "^[a-zA-Z-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        if predicate.evaluate(with: value) {
            return .success
        } else {
            return .failure(ValidationError(
                key: ValidationErrorKey.invalidUserId.rawValue
            ))
        }
    }
}
