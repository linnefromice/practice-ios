import Foundation

public protocol Validator {
    associatedtype Value
    func validate(_ value: Value) -> ValidationResult
}

public struct CompositeValidator<Value>: Validator {
    private let validators: [AnyValidator<Value>]
    
    public init(validators: [AnyValidator<Value>]) {
        self.validators = validators
    }
    
    public func validate(_ value: Value) -> ValidationResult {
        for validator in validators {
            let result = validator.validate(value)
            if !result.isValid {
                return result
            }
        }
        return .success
    }
}

public struct AnyValidator<Value>: Validator {
    private let _validate: (Value) -> ValidationResult
    
    public init<V: Validator>(_ validator: V) where V.Value == Value {
        self._validate = validator.validate
    }
    
    public func validate(_ value: Value) -> ValidationResult {
        _validate(value)
    }
}

public struct ValidationError: LocalizedError, Equatable {
    public let key: String
    public let arguments: [CVarArg]

    public var errorDescription: String? {
        // NSLocalizedString でローカライズした文字列を返す
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, arguments: arguments)
    }

    public init(key: String, arguments: [CVarArg] = []) {
        self.key = key
        self.arguments = arguments
    }
    
    public static func == (lhs: ValidationError, rhs: ValidationError) -> Bool {
        // CVarArg は Equatable に準拠していないため、
        // arguments の比較は String に変換して行う
        let lhsArgs = lhs.arguments.map { String(describing: $0) }
        let rhsArgs = rhs.arguments.map { String(describing: $0) }
        return lhs.key == rhs.key && lhsArgs == rhsArgs
    }
}

public enum ValidationResult: Equatable {
    case success
    case failure(ValidationError)
    
    public var isValid: Bool {
        if case .success = self { return true }
        return false
    }
}
