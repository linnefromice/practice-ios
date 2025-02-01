import Foundation
import CoreImage

@Observable
public class ViewModel {
    
    public var currentFrame: CGImage?
    
    public let cameraManager = CameraManager()
    
    public init() {
        Task {
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
}
