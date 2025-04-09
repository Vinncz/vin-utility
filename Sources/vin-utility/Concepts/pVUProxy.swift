import Foundation


/// A type that bridges between the backing object and the outside world.
/// 
/// Use the `VUProxy` protocol to encapsulate an object and provide simplified interface to access and manage its lifecycle.
/// Extend the `VUProxy` protocol to create custom proxy types that can handle specific behaviors or data types.
protocol VUProxy<T> {
    
    
    /// The type of the backing object.
    /// This is used to determine the type of the object that is being proxied.
    associatedtype T
    
    
    /// The instance (or lack thereof) of the backing object.
    var backing: T? { get }
    
    
    /// Populates the backing object with the given value.
    func populate(with value: T) -> Void
    
    
    /// Depopulates the backing object.
    func depopulate() -> Void
    
}


/// Utility functionality for the ``VUProxy`` protocol.
extension VUProxy {
    
    
    /// The type of the backing object.
    /// This is used to determine the type of the object that is being proxied.
    var backingType: T.Type {
        return T.self
    }
    
    
    /// The state of the proxy.
    var isOperational: Bool {
        return backing != nil
    }
    
}


/// Default, concrete implementation of the ``VUProxy`` protocol with no customized behavior.
class VProxyObject<T>: VUProxy where T: AnyObject {
    
    
    /// The instance (or lack thereof) of the backing object.
    var backing: T?
    
    
    /// Populates the backing object with the given value.
    func populate(with value: T) -> Void {
        backing = value
    }
    
    
    /// Depopulates the backing object.
    func depopulate() -> Void {
        backing = nil
    }
    
}
