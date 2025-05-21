import Foundation



/// Set of requirements for a type that fabricates some data and places it into a storage.
public protocol VUFabricatorQuerist<FabricatorKey, FabricatorArgument, FabricatorReturnValue, FabricatorFault>: VUPlacerQuerist {
    
    
    /// Protocol conformances.
    associatedtype FabricatorKey
    associatedtype FabricatorArgument
    associatedtype FabricatorReturnValue
    associatedtype FabricatorFault: Error
    
    
    /// Fabricates something under guidance by the given arguments, and places it into storage. 
    func fabricate(for key: FabricatorKey, _ arguments: [FabricatorArgument]?) 
        -> Result<FabricatorReturnValue, FabricatorFault> 
    
}
