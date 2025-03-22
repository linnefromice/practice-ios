public struct VoidSuccess: Codable, Sendable, Hashable {
    public init() {}
}
public enum ExecutionStatus<T>: Equatable where T: Equatable {
    case success(T)
    case validationError(String)
    case globalError

    public static func == (lhs: ExecutionStatus<T>, rhs: ExecutionStatus<T>) -> Bool {
        switch (lhs, rhs) {
        case (.success(let lValue), .success(let rValue)):
            return lValue == rValue
        case (.validationError(let lError), .validationError(let rError)):
            return lError == rError
        case (.globalError, .globalError):
            return true
        default:
            return false
        }
    }
}
