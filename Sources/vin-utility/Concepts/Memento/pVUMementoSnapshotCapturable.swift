import Foundation



/// Type whose state can be saved or exported to a snapshot.
public protocol VUMementoSnapshotCapturable<SnapshotResultType, SnapshotCaptureError> {
    
    
    associatedtype SnapshotResultType: VUMementoSnapshot
    associatedtype SnapshotCaptureError: Error
    
    
    /// Constructs a ``VUMementoSnapshot``-conforming object, capturing the current state of the object.
    /// 
    /// - Returns: The snapshot of the object.
    func captureSnapshot() async -> Result<SnapshotResultType, SnapshotCaptureError>
    
}
