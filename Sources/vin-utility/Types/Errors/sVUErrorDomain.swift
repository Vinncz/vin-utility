import Foundation

enum VUErrorDomain: UInt16 {
    
    case CaptureDevice = 0b0001

    case Codable = 0b0010
    
    case CoreData = 0b0011
    
    case CoreLocation = 0b0100
    
    case DataStorage = 0b0101
    
    case FileManager = 0b0110
    
    case Keychain = 0b0111
    
    case Miscellaneous = 0b1000
    
    case Network = 0b1001
    
    case Security = 0b1010
    
    case UIKit = 0b1011
    
    case UserDefaults = 0b1100
    
    case UserActivity = 0b1101
    
    case Validation = 0b1110
    
    case WebKit = 0b1111
    
}
