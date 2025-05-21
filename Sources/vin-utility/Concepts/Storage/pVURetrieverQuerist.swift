import Foundation



/// Set of requirements for a type that checks the presence of a key and retrieves data from a storage.
public protocol VURetrieverQuerist<RetrieverKey, RetrieverReturnValue, RetrieverFault>: VUQuerist {
    
    
    /// Protocol conformances.
    associatedtype RetrieverKey
    associatedtype RetrieverReturnValue
    associatedtype RetrieverFault: Error
    
    
    /// Performs a lookup to test the presence of a value for the given key.
    func check(for key: RetrieverKey) 
        -> Result<Bool, RetrieverFault> 
    
    
    /// Retrieves the value associated with a given key.
    func retrieve(for key: RetrieverKey, limit: Int) 
        -> Result<RetrieverReturnValue, RetrieverFault> 
    
}
