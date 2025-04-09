import Foundation

/// A type that wraps a value of a specific type. A bunch of this type can be used to create a type-erased collection of values.
enum VUTypeWrapper<Value> {
    
    /// The wrapped value.
    case wrap (Value)
    
}

extension VUTypeWrapper {
    
    /// Retrieve the associated value as an instance of specific type (Int, String, etc.)
    /// 
    /// Example:
    /// ```
    /// let config : [Config: VUTypeWrapper<Any>] = [:]
    /// 
    /// let res = config[.scrollable].take(as: Bool.self) // res is of type Bool?
    /// ```
    func take <RequestedType> ( as type: RequestedType.Type ) -> RequestedType? {
        switch self {
            case .wrap (let val):
                val as? RequestedType
        }
    }
    
    /// Retrieve the associated value as an instance of specific type (Int, String, etc.)
    /// 
    /// Example:
    /// ```
    /// let config : [Config: VUTypeWrapper<Any>] = [:]
    /// 
    /// let res = config[.scrollable].take(as: [Bool.self]) // res is of type [Bool]?
    /// ```
    func take <RequestedType> ( as type: [RequestedType.Type] ) -> [RequestedType] {
        switch self {
            case .wrap (let vals):
                vals as? [RequestedType] ?? []
        }
    }
    
    /// Retrieve the associated value as an instance of specific type, given the conversion function.
    func take <RequestedType> ( as type: RequestedType.Type, using conversionFunction: (Value) -> RequestedType ) -> RequestedType? {
        switch self {
            case .wrap (let val):
                conversionFunction(val)
        }
    }
    
}

extension VUTypeWrapper : Equatable where Value : Equatable {
    
    static func == ( lhs: VUTypeWrapper<Value>, rhs: VUTypeWrapper<Value> ) -> Bool {
        lhs.take(as: Value.self) == rhs.take(as: Value.self)
    }
    
}
