import Foundation



public extension VUError {    
    
    
    static func CodableDomainError(underlying error: Error) -> VUError {
        .init(
            name: "CODABLE_DOMAIN_ERROR", 
            code: 0b0100_0000, 
            domain: .Codable, 
            userInfo: [
                NSUnderlyingErrorKey: error
            ]
        )
    }
    
    
    static let DERIVATION_FAILURE = VUError(
        name: "DERIVATION_FAILURE",
        code: 0b0100_0001,
        domain: .Codable,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Unsuccessfully derived a value into some type.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The value could not be derived into the type.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the value and the type you are trying to derive it into.", comment: "")
        ]
    )
    
    
    static let MALFORMED = VUError(
        name: "MALFORMED",
        code: 0b0100_0010,
        domain: .Codable,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Keys which were expected or needed, were not found.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Some key-value pairings were not found.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Log the object you are trying to decode, and check the keys you are using.", comment: "")
        ]
    )
    
    
    static let TYPE_MISMATCH = VUError(
        name: "TYPE_MISMATCH",
        code: 0b0100_0011,
        domain: .Codable,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Type mismatch.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The type of the value does not match the type of the key.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the type of the value and the type of the key.", comment: "")
        ]
    )
    
    
    static let PARSE_FAILURE = VUError(
        name: "PARSE_FAILURE",
        code: 0b0100_0100,
        domain: .Codable,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Failed to parse the object.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The object could not be parsed.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the object and the parser you are using.", comment: "")
        ]
    )
    
    
    static let ENCODE_FAILURE = VUError(
        name: "ENCODE_FAILURE",
        code: 0b0100_0101,
        domain: .Codable,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Failed to encode the object.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The object could not be encoded.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the object and the encoder you are using.", comment: "")
        ]
    )
    
    
    static let DECODE_FAILURE = VUError(
        name: "DECODE_FAILURE",
        code: 0b0100_0110,
        domain: .Codable,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Failed to decode the object.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("The object could not be decoded.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check the object and the decoder you are using.", comment: "")
        ]
    )
    
}
