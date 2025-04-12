import Foundation



/// A saved, serialized state of an object for a moment in time.
public protocol VUMementoSnapshot: Codable {
    
    
    /// The unique identifier of the snapshot.
    var id: UUID { get }
    
    
    /// The tag of the snapshot.
    var tag: String? { get set }
    
    
    /// The date the snapshot was taken.
    var takenOn: Date { get }
    
    
    /// The version of the object at the time of the snapshot.
    var version: String? { get }
    
}
