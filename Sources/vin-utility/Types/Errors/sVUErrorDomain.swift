import Foundation

public enum VUErrorDomain: UInt16 {
    
    case Custom = 0b0000_0000
    
    case CaptureDevice = 0b000_0001

    case Codable = 0b000_0010
    
    case CoreData = 0b000_0011
    
    case Location = 0b000_0100
    
    case DataStorage = 0b000_0101
    
    case FileManager = 0b000_0110
    
    case Keychain = 0b000_0111
    
    case Miscellaneous = 0b000_1000
    
    case Network = 0b000_1001
    
    case Security = 0b000_1010
    
    case SwiftConcurrency = 0b000_1011
    
    case UIKit = 0b000_1100
    
    case UserDefaults = 0b000_1101
    
    case UserActivity = 0b000_1110
    
    case Validation = 0b000_1111
    
}
