import Foundation
import os
import Security

public func VUConvertKeyToData(_ inputKey: SecKey) -> Result<Data, Error> {
    
    var error: Unmanaged<CFError>?
    let externalRep = SecKeyCopyExternalRepresentation(inputKey, &error)
    
    if let externalRep {
        return .success(externalRep as Data)
        
    } else if let error = error?.takeRetainedValue() {
        return .failure(error)
        
    } else {
        return .failure(VUError.UNKNOWN)
        
    }
    
}
