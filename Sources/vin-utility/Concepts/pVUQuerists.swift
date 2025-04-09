import Foundation


/// The base type for all `Querist` type.
protocol VUQuerist {}


/// Set of requirements for a type that fabricates some data and places it into a storage.
protocol VUFabricatorQuerist<FabricatorKey, FabricatorArgument, FabricatorReturnValue, FabricatorFault>: VUPlacerQuerist {
    
    
    /// Protocol conformance.
    associatedtype FabricatorKey
    associatedtype FabricatorArgument
    associatedtype FabricatorReturnValue
    associatedtype FabricatorFault: Error
    
    
    /// Fabricates something under guidance by the given arguments, and places it into storage. 
    func fabricate(for key: FabricatorKey, _ arguments: [FabricatorArgument]?) 
        -> Result<FabricatorReturnValue, FabricatorFault> 
    
}


/// Set of requirements for a type that places data into a storage.
protocol VUPlacerQuerist<PlacerKey, PlacerInputValue, PlacerReturnValue, PlacerFault>: VUQuerist {
    
    
    /// Protocol conformance.
    associatedtype PlacerKey
    associatedtype PlacerInputValue
    associatedtype PlacerReturnValue
    associatedtype PlacerFault: Error
    
    
    /// Places the given data with the given key into storage.
    @discardableResult func place(for key: PlacerKey, data: PlacerInputValue) 
        -> Result<PlacerReturnValue, PlacerFault> 
    
}


/// Set of requirements for a type that removes data from a storage.
protocol VURemoverQuerist<RemoverKey, RemoverReturnValue, RemoverFault>: VUQuerist {
    
    
    /// Protocol conformance.
    associatedtype RemoverKey
    associatedtype RemoverReturnValue
    associatedtype RemoverFault: Error
    
    
    /// Removes any value associated with the given key.
    @discardableResult func remove(for key: RemoverKey) 
        -> Result<RemoverReturnValue, RemoverFault>
    
}


/// Set of requirements for a type that checks the presence of a key and retrieves data from a storage.
protocol VURetrieverQuerist<RetrieverKey, RetrieverReturnValue, RetrieverFault>: VUQuerist {
    
    
    /// Protocol conformance.
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
