import Foundation



public extension VUError {
    
    
    public static let NO_SUITABLE_CAMERA = VUError(
        name: "NO_SUITABLE_CAMERA",
        code: 0b1100_0010, 
        domain: .CaptureDevice, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Device has no suitable camera.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The device has no camera or any compatible camera is in use.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check whether a camera is present, and make sure its not in use.", comment: "")
        ]
    )
    
    
    public static let NO_SUITABLE_MICROPHONE = VUError(
        name: "NO_SUITABLE_MICROPHONE",
        code: 0b1100_0001, 
        domain: .CaptureDevice, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Device has no suitable microphone.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The device has no microphone or any compatible microphone is in use.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check whether a microphone is present, and make sure its not in use.", comment: "")
        ]
    )
    
    
    public static let NO_PERMISSION_CAMERA = VUError(
        name: "NO_PERMISSION_CAMERA",
        code: 0b1000_0010, 
        domain: .CaptureDevice, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("No permission to access the camera.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The user has denied the permission, disabled the permission, or has yet to grant permission.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Go to settings and enable the camera permission for the app.", comment: "")
        ]
    )
    
    
    public static let NO_PERMISSION_MICROPHONE = VUError(
        name: "NO_PERMISSION_MICROPHONE",
        code: 0b1000_0001, 
        domain: .CaptureDevice, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("No permission to access the microphone.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The user has denied the permission, disabled the permission, or has yet to grant permission.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Go to settings and enable the microphone permission for the app.", comment: "")
        ]
    )
    
}
