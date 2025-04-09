import Foundation


/// Represents an error that happened inside the FixPro Mobile application.
struct VUError: LocalizedError {
    
    
    /// A unique code. Uniquely identifies one error from another; 
    /// when they came from the same domain.
    let code: Int
    
    
    /// Identifies where the error comes from.
    let domain: VUErrorDomain
    
    
    /// A dictionary containing additional information regarding what went wrong.
    let userInfo: [String: Any]
    
    
    /// General, human-readable summary of what went wrong.
    /// Targetted for end users, it sums the problem up that answers most of their question.
    var errorDescription: String? {
        return userInfo[NSLocalizedDescriptionKey] as? String
    }
    
    
    /// A somewhat comprehensive, technical statement about why it went wrong.
    /// Targetted for developers or savvy individuals, it should tips them to where the cause lies.
    var failureReason: String? {
        return userInfo[NSLocalizedFailureReasonErrorKey] as? String
    }
    
    
    /// A hint or probable way to solve the problem.
    /// Targeted for end users.
    var recoverySuggestion: String? {
        return userInfo[NSLocalizedRecoverySuggestionErrorKey] as? String
    }
    
}


extension VUError: Equatable {
    
    static func == (lhs: VUError, rhs: VUError) -> Bool {
        lhs.code == rhs.code
        && lhs.domain == rhs.domain
    }
    
}


extension VUError {    
    
    
    /// A generic error. Little is known about what or where it went wrong.
    static let UNKNOWN: VUError = .init(
        code: 37,
        domain: .Miscellaneous,
        userInfo: [:]
    )
    
}
