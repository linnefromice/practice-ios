// Mockup for handling verification by ExecutionStatus
import Foundation

class RemoteCallService {
    func call(isSuccess: Bool, errorMessage: String) async -> ExecutionStatus<VoidSuccess> {
        if isSuccess {
            return .success(VoidSuccess())
        }
        if errorMessage.isEmpty {
            return .globalError
        }
        return .validationError(errorMessage)
    }
}
