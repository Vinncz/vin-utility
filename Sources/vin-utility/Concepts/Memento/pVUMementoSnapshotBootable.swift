import Foundation



/// Type that support instantiation from a snapshot of it.
public protocol VUMementoSnapshotBootable<InstantiatedType, BootSnapshotType, BootError> {
    
    
    associatedtype InstantiatedType
    associatedtype BootSnapshotType: VUMementoSnapshot
    associatedtype BootError: Error
    
    
    /// Initializes an object based on the given snapshot.
    ///
    /// - Parameter snapshot: The snapshot to restore from.
    /// - Returns: An instance of the type, with all of its attributes set same as the snapshot's.
    static func boot(fromSnapshot snapshot: BootSnapshotType) -> Result<InstantiatedType, BootError>
    
}
