import Foundation



public extension VUError {
    
    
    public static let NO_NETWORK = VUError(
        name: "NO_NETWORK",
        code: 0b1000_0000,
        domain: .Network,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("No network connection.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The device is not connected to the internet.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check your network connection and try again.", comment: "")
        ]
    )
    
    
    public static let UNREACHABLE = VUError(
        name: "UNREACHABLE",
        code: 0b1000_0001,
        domain: .Network,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Unreachable host.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The host is unreachable.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the host address, confirm that they are re online, then try again.", comment: "")
        ]
    )
    
    
    public static let TIMEOUT = VUError(
        name: "TIMEOUT",
        code: 0b1000_0010,
        domain: .Network,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Request timed out.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The request took too long to complete.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check your network speed, packet loss, and jitter, then try again.", comment: "")
        ]
    )
    
    
    public static let UNEXPECTED_RESPONSE = VUError(
        name: "UNEXPECTED_RESPONSE",
        code: 0b1000_0011,
        domain: .Network,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Server gave response in unexpected format.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The server responded with response that breaks the parser.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the server response, configure the parser to handle it, then try again.", comment: "")
        ]
    )
    
    
    public static let SERVER_ERROR = VUError(
        name: "SERVER_ERROR",
        code: 0b1000_0100,
        domain: .Network,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Server error.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The server could not process the request.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the server status, and try again later.", comment: "")
        ]
    )
    
    
    public static let UNAUTHENTICATED = VUError(
        name: "UNAUTHENTICATED",
        code: 0b1000_0101, 
        domain: .Network, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Unauthenticated.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Credentials may be missing, invalid, or expired.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Revalidate the credentials, then try again.", comment: "")
        ]
    )
    
    
    public static let FORBIDDEN = VUError(
        name: "FORBIDDEN",
        code: 0b1000_0110, 
        domain: .Network, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Forbidden.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The server refused to process the request.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the credentials, permissions granted by it, then try again.", comment: "")
        ]
    )
    
    
    public static let NOT_FOUND = VUError(
        name: "NOT_FOUND",
        code: 0b1000_0111, 
        domain: .Network, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Not found.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The requested resource was not found.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the resource identifier, and try again.", comment: "")
        ]
    )
    
    
    public static let INVALID_ADDRESS = VUError(
        name: "INVALID_ADDRESS",
        code: 0b1000_1000, 
        domain: .Network, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Address is incorrectly written.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The address does not conform to a correct URL scheme.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Ensure there are no typo on the address, then try again.", comment: "")
        ]
    )
    
    
    public static let BAD_REQUEST = VUError(
        name: "BAD_REQUEST",
        code: 0b1000_1001, 
        domain: .Network, 
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Bad request.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The request was malformed or was missing required parameters.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the request parameters, and try again.", comment: "")
        ]
    )
    
}
