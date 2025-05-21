import Foundation



/// A concrete implementation of ``VUMonadFlow`` for asynchronous operations.
public struct VUMonadAsyncFlow<T>: VUMonadFlow {
    
    
    /// 
    private let computation: () async throws -> T
    
    
    /// 
    public init(_ computation: @escaping () async throws -> T) {
        self.computation = computation
    }
    
    
    /// Evaluates the flow and produces a result.
    public func evaluate() async throws -> T {
        return try await computation()
    }
    
}
