import Foundation



public extension VUError {
    
    
    static func ValidationDomainError(underlying error: Error) -> VUError {
        .init(
            name: "VALIDATION_DOMAIN_ERROR", 
            code: 0b0011_0000, 
            domain: .Validation, 
            userInfo: [
                NSUnderlyingErrorKey: error
            ]
        )
    }
    
    
    static let EMPTY_ARGUMENT = VUError(
        name: "EMPTY_ARGUMENT",
        code: 0b0011_0000,
        domain: .Validation,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("No argument was provided where it was expected.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The argument was nil or empty.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Fill in the argument, then try again.", comment: "")
        ]
    )
    
    
    static let ILLEGAL_ARGUMENT = VUError(
        name: "ILLEGAL_ARGUMENT",
        code: 0b0011_0001,
        domain: .Validation,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Unacceptable argument was provided.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Argument may bear an incorrect type, illegal value, or in an unacceptable format.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Revalidate the argument, then try again.", comment: "")
        ]
    )
    
    
    static let INCOMPLETE_ARGUMENT = VUError(
        name: "INCOMPLETE_ARGUMENT",
        code: 0b0011_0010,
        domain: .Validation,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Incomplete argument was provided.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The argument is missing some required values.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Fill in the missing values, then try again.", comment: "")
        ]
    )
    
    
    static let INCOMPLETE_RECORDS = VUError(
        name: "INCOMPLETE_RECORDS",
        code: 0b0011_0011,
        domain: .Validation,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Record is incomplete, hence unable to procede.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The record is missing some required values.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Fill in the missing values, then try again.", comment: "")
        ]
    )
    
}
