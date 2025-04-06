import Foundation

public struct NonEmptyValidator: Validator {
    public init() {}

    public func validate(_ value: String) -> ValidationResult {
        if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .failure(ValidationError(key: ValidationErrorKey.nonEmpty.rawValue))
        }
        return .success
    }
}
