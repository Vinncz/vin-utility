import Foundation



/// A type that bridges between the backing object and the outside world.
/// 
/// Use the `VUProxy` public protocol to encapsulate an object and provide simplified interface to access and manage its lifecycle.
/// Extend the `VUProxy` public protocol to create custom proxy types that can handle specific behaviors or data types.
public protocol VUProxy<T> {
    
    
    /// The type of the backing object.
    /// Used to determine the type of the object that is being proxied.
    associatedtype T
    
    
    /// The instance (or lack thereof) of the backing object.
    var backing: T? { get }
    
    
    /// Populates the backing object with the given value.
    func back(with value: T) -> Void
    
    
    /// Depopulates the backing object.
    func pull() -> Void
    
}



/// Utility public functionality for the ``VUProxy`` public protocol.
public extension VUProxy {
    
    
    /// The type of the backing object.
    /// This is used to determine the type of the object that is being proxied.
    var backingType: T.Type {
        T.self
    }
    
    
    /// The state of the proxy.
    var isBacked: Bool {
        backing != nil
    }
    
}



/// Default, concrete implementation of the ``VUProxy`` public protocol with no customized behavior.
open class VUProxyObject<T>: VUProxy {
    
    
    /// The instance (or lack thereof) of the backing object.
    public var backing: T?
    
    
    /// Creates a new instance of the proxy object.
    public init() {
        backing = nil
    }
    
    
    /// Populates the backing object with the given value.
    public func back(with value: T) -> Void {
        backing = value
    }
    
    
    /// Depopulates the backing object.
    public func pull() -> Void {
        backing = nil
    }
    
}
