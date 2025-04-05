import Foundation

public struct NonEmptyValidator: Validator {
    public init() {}

    public func validate(_ value: String) -> ValidationResult {
        if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            // キー "error.nonEmpty" に対応するローカライズされたメッセージを用意しておく
            return .failure(ValidationError(key: "error.nonEmpty"))
        }
        return .success
    }
}
