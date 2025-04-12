import Foundation



/// Type that can be saved and restored to a previous state.
public protocol VUMementoSnapshotable {
    
    
    /// Constructs a ``VUMementoSnapshot`` object, capturing the current state of the object.
    /// 
    /// - Returns: The snapshot of the object.
    func captureSnapshot() -> Result<VUMementoSnapshot, VUError>
    
    
    /// Restores the state according to the given snapshot.
    ///
    /// - Parameter snapshot: The snapshot to restore from.
    @discardableResult func restore(from snapshot: VUMementoSnapshot) -> Result<Void, VUError>
    
}
