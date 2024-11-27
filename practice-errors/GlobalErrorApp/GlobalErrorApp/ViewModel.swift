import Foundation

public enum GlobalError: Error {
    case invalid
    case unknown
}

@Observable
public class ErrorState {
    var error: GlobalError?
    
    func setError(_ err: GlobalError) {
        error = err
    }
    func clearError() {
        error = nil
    }
}
