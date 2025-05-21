import Foundation



/// Type that can be saved and restored to a previous version of itself.
public typealias VUMementoSnapshotable = VUMementoSnapshotCapturable & VUMementoSnapshotRestorable



/// Type that can be saved, restored, and instantiated from and to a snapshot version of itself.
public typealias VUMementoPerfectSnapshotable = VUMementoSnapshotBootable & VUMementoSnapshotCapturable & VUMementoSnapshotRestorable
