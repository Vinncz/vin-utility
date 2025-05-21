import Foundation



/// Type that is intelligent in determining how to merge itself with other instance of the same type.
public protocol VUMergable {
    
    
    /// Merges the current instance with another instance of the same type.
    /// - Parameter foreign: The instance to merge with.
    /// - Returns: The merged instance. The same one that this method was called on.
    @discardableResult func merge(with foreign: Self) -> Self
    
}
