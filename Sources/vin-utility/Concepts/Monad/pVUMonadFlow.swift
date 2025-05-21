import Foundation


/// A type that constructs a composable flow of values and effects.
///
/// Use the ``VUMonadFlow`` protocol to build and chain complex operations; executed one after another,
/// while assuming the operation will always be trhowing and asynchronous.
public protocol VUMonadFlow {
    
    
    /// The type of the value being passed through the flow.
    associatedtype Output
    
    
    /// Evaluates the flow and produces a result.
    func evaluate() async throws -> Output
    
}



public extension VUMonadFlow {
    
    
    /// 
    func map<U>(_ transform: @escaping (Output) -> U) -> VUMonadAsyncFlow<U> {
        VUMonadAsyncFlow<U> {
            let value = try await self.evaluate()
            return transform(value)
        }
    }
    
    
    /// 
    func flatMap<U>(_ transform: @escaping (Output) async throws -> U) -> VUMonadAsyncFlow<U> {
        VUMonadAsyncFlow<U> {
            let value = try await self.evaluate()
            return try await transform(value)
        }
    }
    
    
    /// 
    func softMap<U>(_ transform: @escaping (Output) -> U) -> VUMonadAsyncFlow<U> {
        VUMonadAsyncFlow<U> {
            do {
                let value = try await self.evaluate()
                return transform(value)
                
            } catch {
                throw error
                
            }
        }
    }
    
    
    /// 
    func softFlatMap<U>(_ transform: @escaping (Output) async throws -> U) -> VUMonadAsyncFlow<U> {
        VUMonadAsyncFlow<U> {
            do {
                let value = try await self.evaluate()
                return try await transform(value)
                
            } catch {
                throw error
                
            }
        }
    }
    
    
    /// Clears 
    func onError(_ handler: @escaping (Error) -> Void) -> VUMonadAsyncFlow<Output> {
        VUMonadAsyncFlow<Output> {
            do {
                return try await self.evaluate()
                
            } catch {
                handler(error)
                throw error
                
            }
        }
    }
    
    
    /// Logs the result of the flow into console, including success or failure cases.
    func debug(_ label: String = "") -> VUMonadAsyncFlow<Output> {
        VUMonadAsyncFlow<Output> {
            do {
                let result = try await self.evaluate()
                VULogger.log(tag: .success, "[VUMonadFlow] \(label) succeeded: \(result)")
                return result
                
            } catch {
                VULogger.log(tag: .error, "[VUMonadFlow] \(label) failed: \(error)")
                throw error
                
            }
        }
    }
    
}
