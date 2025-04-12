import Foundation



/// Type that uses a shorthand `val` to access an associated value.
public protocol VUAssociableWithValue {
    
    associatedtype Value
    
    var val : Value { get }
    
}
