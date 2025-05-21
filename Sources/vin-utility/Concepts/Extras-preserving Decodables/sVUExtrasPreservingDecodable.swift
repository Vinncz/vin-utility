import Foundation



/// 
public struct VUExtrasPreservingDecodable<Underlying: Decodable>: Decodable {
    
    
    public let model: Underlying
    
    
    public let extras: [String: VUAnyCodable]
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VUAnyCodingKey.self)
        
        // Step 1 -- Decode known fields into the base model.
        let model = try Underlying(from: decoder)
        
        // Step 2 -- Reflect known keys.
        let knownKeySet = Set(Mirror(reflecting: model).children.compactMap { $0.label })
        
        // Step 3 -- Decode the rest.
        var extras: [String: VUAnyCodable] = [:]
        for key in container.allKeys where !knownKeySet.contains(key.stringValue) {
            if let val = try? container.decode(VUAnyCodable.self, forKey: key) {
                extras[key.stringValue] = val
            }
        }
        
        self.model = model
        self.extras = extras
    }
    
}



public extension VUExtrasPreservingDecodable {
    
    
    func extrasAsStringMap() -> [String: String] {
        return extras.mapValues { "\($0)" }
    }
    
}



extension VUExtrasPreservingDecodable: Encodable where Underlying: Encodable {
    
    
    public func encode(to encoder: any Encoder) throws {
        try model.encode(to: encoder)
        
        var container = encoder.container(keyedBy: VUAnyCodingKey.self)
        for (key, value) in extras {
            try container.encode(value, forKey: VUAnyCodingKey(stringValue: key)!)
        }
    }
    
}
