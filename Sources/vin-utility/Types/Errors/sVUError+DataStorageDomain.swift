import Foundation



public extension VUError {    
    
    
    public static let DUPLICATE_ENTRY = VUError(
        name: "DUPLICATE_ENTRY",
        code: 0b0001_0001,
        domain: .DataStorage,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Preexisting entry found. Stopped before overwriting.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Refused to overwrite an existing entry.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check or delete the existing entry before writing a new one.", comment: "")
        ]
    )
    
    
    public static let MISSING_ENTRY = VUError(
        name: "MISSING_ENTRY",
        code: 0b0001_0010,
        domain: .DataStorage,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("No entry found.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The requested entry does not exist.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check whether the identifier is correct, and you are looking in the right place.", comment: "")
        ]
    )
    
    
    public static let UNLOADED_ENTRY = VUError(
        name: "UNLOADED_ENTRY",
        code: 0b0001_0011,
        domain: .DataStorage,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("No entry found.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The requested entry has not yet been loaded into memory.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Perform a subsequent load operation and try again.", comment: "")
        ]
    )
    
    
    public static let INVALID_ENTRY = VUError(
        name: "INVALID_ENTRY",
        code: 0b0001_0100,
        domain: .DataStorage,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Illegal entry found.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("An entry that shouldn't be there or is bearing an illegal or improbable value was found.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Remove the entry, or fix the value.", comment: "")
        ]
    )
    
}
