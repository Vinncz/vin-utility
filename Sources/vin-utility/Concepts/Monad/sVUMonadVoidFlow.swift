import Foundation



/// 
public struct VUMonadVoidFlow: VUMonadFlow {
    
    
    /// 
    public typealias Output = Void
    
    
    /// 
    private let effect: () async throws -> Void
    
    
    /// 
    public init(_ effect: @escaping () async throws -> Void) {
        self.effect = effect
    }
    
    
    /// Evaluates the flow and produces a result.
    public func evaluate() async throws {
        try await effect()
    }
    
}
