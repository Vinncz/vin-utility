import Foundation
import os
import Security

struct DERIVATION_ERROR: LocalizedError {
    var errorDescription: String? {
        ""
    }
    var failureReason: String? {
        ""
    }
    var recoverySuggestion: String? {
        ""
    }
    var helpAnchor: String? {
        ""
    }
}

public func VUDerivePublicKey(fromPrivateKey privateKey: SecKey) -> Result<SecKey, Error> {
    let publicKey = SecKeyCopyPublicKey(privateKey)
    
    if let publicKey {
        return .success(publicKey)
    } else {
        return .failure(DERIVATION_ERROR())
    }
}
