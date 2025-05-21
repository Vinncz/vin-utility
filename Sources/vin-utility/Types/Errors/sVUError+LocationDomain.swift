import Foundation



extension VUError {
    
    
    static func LocationDomainError(underlying error: Error) -> VUError {
        .init(
            name: "LOCATION_DOMAIN_ERROR", 
            code: 0b0101_1010, 
            domain: .Location, 
            userInfo: [
                NSUnderlyingErrorKey: error
            ]
        )
    }
    
}
