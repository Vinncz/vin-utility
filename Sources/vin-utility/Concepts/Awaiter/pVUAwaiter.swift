import Foundation



/// A one-time, externally-driven async value.
/// Combine-like publisher that is fitted for Swift concurrency.
public protocol VUAwaiter<T>: AnyObject {
    
    
    associatedtype T
    
    
    /// The continuation used to resume the suspended `await()`.
    /// > Note: Do not touch this manually unless you're implementing this protocol.
    var continuation: CheckedContinuation<T, VUError>? { get set }
    
    
    /// Waits for ``fulfill(_:)`` or ``fail(_:)`` to be called.
    /// If the value was already fulfilled, returns immediately.
    /// If it was failed, throws the error.
    /// Otherwise suspends the current task until it's resolved.
    func await() async throws -> T
    
    
    /// 
    func fail(_ error: VUError)
    
    
    /// 
    func fulfill(_ value: T)
    
    
    /// 
    func reset()
    
}



public class VUAwaiterObject<T>: VUAwaiter, @unchecked Sendable {
    
    
    /// 
    public var continuation: CheckedContinuation<T, VUError>?
    
    
    /// 
    private var state: State = .pending
    
    
    
    public init(continuation: CheckedContinuation<T, VUError>? = nil, state: State = .pending) {
        self.continuation = continuation
        self.state = state
    }
    
    
    ///
    public func await() async throws -> T {
        if case let .fulfilled(value) = state { return value }
        if case let .failed(error) = state { throw error }

        return try await withCheckedThrowingContinuation { cont in
            continuation = cont as? CheckedContinuation<T, VUError>
        }
    }
    
    
    /// 
    public func fulfill(_ value: T) {
        guard case .pending = state else { return }
        state = .fulfilled(value)
        
        continuation?.resume(returning: value)
    }
    
    
    /// 
    public func fail(_ error: VUError) {
        guard case .pending = state else { return }
        state = .failed(error)
        
        continuation?.resume(throwing: error)
    }
    
    
    /// 
    public func reset() {
        continuation = nil
        state = .pending
    }
    
}



public extension VUAwaiterObject {
    
    
    /// 
    enum State {
        
        /// 
        case pending
        
        /// 
        case fulfilled(T)
        
        /// 
        case failed(VUError)
        
    }
    
}
