import Foundation



/// A concrete implementation of ``VUMonadFlow`` for synchronous operations.
public struct VUMonadSyncFlow<T>: VUMonadFlow {
    
    
    /// 
    private let computation: () throws -> T
    
    
    /// Instantiates a new ``VUMonadSyncFlow`` with the given computation.
    public init(_ computation: @escaping () throws -> T) {
        self.computation = computation
    }
    
    
    /// Evaluates the flow and produces a result.
    public func evaluate() async throws -> T {
        return try computation()
    }
    
}
