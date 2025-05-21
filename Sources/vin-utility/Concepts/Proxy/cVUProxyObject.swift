import Foundation



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
