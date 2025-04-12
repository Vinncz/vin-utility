import Foundation



/// Type that triggers taking, saving, and restoring snapshots.
public protocol VUMementoAgent {
    
    
    /// Attempts to persists the current state of the object.
    @discardableResult func takeSnapshot(tag: String?) -> Result<VUMementoSnapshot, VUError>
    
    
    /// Attempts to restore the object to a previous state.
    func restore<T: VUMementoSnapshot>() -> Result<T, VUError> 
    
}
