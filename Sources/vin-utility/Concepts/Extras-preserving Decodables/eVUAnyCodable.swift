import Foundation



/// Flight-School-inspired extended decodables.
public enum VUAnyCodable: Codable, CustomStringConvertible, Equatable, Hashable {
    
    
    case string(String)
    
    
    case int(Int)
    
    
    case double(Double)
    
    
    case bool(Bool)
    
    
    case null
    
    
    case array([VUAnyCodable])
    
    
    case dictionary([String: VUAnyCodable])
    
    
    public var description: String {
        switch self {
        case .string(let s): 
            return s
        case .int(let i): 
            return "\(i)"
        case .double(let d): 
            return "\(d)"
        case .bool(let b): 
            return "\(b)"
        case .null: 
            return "null"
        case .array(let a):
            return "\(a)"
        case .dictionary(let t):
            return "\(t)"
        }
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .null
            
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
            
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
            
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
            
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
            
        } else if let array = try? container.decode([VUAnyCodable].self) {
            self = .array(array)
            
        } else if let dictionary = try? container.decode([String: VUAnyCodable].self) {
            self = .dictionary(dictionary)
            
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Illegal JSON.")
        }
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        case .array(let array):
            try container.encode(array)
        case .dictionary(let dictionary):
            try container.encode(dictionary)
        }
    }
    
}
