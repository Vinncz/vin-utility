import Foundation



/// Set of requirements for a type that places data into a storage.
public protocol VUPlacerQuerist<PlacerKey, PlacerInputValue, PlacerReturnValue, PlacerFault>: VUQuerist {
    
    
    /// Protocol conformances.
    associatedtype PlacerKey
    associatedtype PlacerInputValue
    associatedtype PlacerReturnValue
    associatedtype PlacerFault: Error
    
    
    /// Places the given data with the given key into storage.
    @discardableResult func place(for key: PlacerKey, data: PlacerInputValue) 
        -> Result<PlacerReturnValue, PlacerFault> 
    
}
