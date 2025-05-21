import Foundation



/// 
public struct VUAnyCodingKey: CodingKey {
    
    
    public var stringValue: String
    
    
    public var intValue: Int?
    
    
    public init?(stringValue: String) { 
        self.stringValue = stringValue 
    }
    
    
    public init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
    
}
