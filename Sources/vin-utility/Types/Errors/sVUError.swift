import Foundation



/// A descriptive error.
public struct VUError: LocalizedError, CustomDebugStringConvertible {
    
    
    /// A unique name. Uniquely identifies one error from another within the same domain.
    public let name: String
    
    
    /// A unique code. Uniquely identifies one error from another within the same domain.
    public let code: Int
    
    
    /// Identifies where the error comes from.
    public let domain: VUErrorDomain
    
    
    /// A dictionary containing additional information regarding what went wrong.
    public let userInfo: [String: Any]
    
    
    /// Creates a new error.
    public init(name: String, code: Int, domain: VUErrorDomain, userInfo: [String: Any]) {
        self.name = name
        self.code = code
        self.domain = domain
        self.userInfo = userInfo
    }
    
    
    /// General, human-readable summary of what went wrong.
    /// Targetted for end users, it sums the problem up that answers most of their question.
    public var errorDescription: String? {
        return userInfo[NSLocalizedDescriptionKey] as? String
    }
    
    
    /// A somewhat comprehensive, technical statement about why it went wrong.
    /// Targetted for developers or savvy individuals, it should tips them to where the cause lies.
    public var failureReason: String? {
        return userInfo[NSLocalizedFailureReasonErrorKey] as? String
    }
    
    
    /// A hint or probable way to solve the problem.
    /// Targeted for end users.
    public var recoverySuggestion: String? {
        return userInfo[NSLocalizedRecoverySuggestionErrorKey] as? String
    }
    
    
    /// A debuggable representation of self.
    public var debugDescription: String {
        """
        
        [\(code)] \(name) • \(domain) • \(failureReason ?? "UNKNOWN REASON")
        \(recoverySuggestion ?? "NOTHING TO SUGGEST")
        """
    }
    
}



extension VUError: Equatable {
    
    public static func == (lhs: VUError, rhs: VUError) -> Bool {
        lhs.code == rhs.code
        && lhs.domain == rhs.domain
    }
    
}



public extension VUError {
    
    
    static let UNKNOWN = VUError(
        name: "UNKNOWN_ERROR",
        code: 0b0010_0101,
        domain: .Miscellaneous,
        userInfo: [
            NSLocalizedDescriptionKey: "An unknown error occurred.",
            NSLocalizedFailureReasonErrorKey: "An unknown error occurred.",
            NSLocalizedRecoverySuggestionErrorKey: "Review the logs for more information.",
        ]
    )
    
}
