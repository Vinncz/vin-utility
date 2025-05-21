import Foundation



/// Type whose state can be restored through a snapshot.
public protocol VUMementoSnapshotRestorable<SnapshotRestoreType, SnapshotRestoreError> {
    
    
    associatedtype SnapshotRestoreType: VUMementoSnapshot
    associatedtype SnapshotRestoreError: Error
    
    
    /// Restores the state according to the given snapshot.
    ///
    /// - Parameter snapshot: The snapshot to restore from.
    @discardableResult func restore(toSnapshot snapshot: SnapshotRestoreType) async -> Result<Void, SnapshotRestoreError>
    
}
