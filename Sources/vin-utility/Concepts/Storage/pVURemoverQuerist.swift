import Foundation



/// Set of requirements for a type that removes data from a storage.
public protocol VURemoverQuerist<RemoverKey, RemoverReturnValue, RemoverFault>: VUQuerist {
    
    
    /// Protocol conformances.
    associatedtype RemoverKey
    associatedtype RemoverReturnValue
    associatedtype RemoverFault: Error
    
    
    /// Removes any value associated with the given key.
    @discardableResult func remove(for key: RemoverKey) 
        -> Result<RemoverReturnValue, RemoverFault>
    
}
