import Foundation



public extension VUError {
    
    
    static let CONCURRENCY_CANCELLED = VUError(
        name: "CONCURRENCY_CANCELLED",
        code: 0b0111_0000,
        domain: .SwiftConcurrency,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Asynchronous task was cancelled.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Asynchronous task was explicitly cancelled.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Nothing. It's purposeful.", comment: "")
        ]
    )
    
    
    static let CONCURRENCY_TIMEOUT = VUError(
        name: "CONCURRENCY_TIMEOUT",
        code: 0b0111_0001,
        domain: .SwiftConcurrency,
        userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("Asynchronous task timed out.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Asynchronous task ran longer than what was allowed.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Check for expensive operations, bottlenecks, or set a higher threshold then try again.", comment: "")
        ]
    )
    
}
