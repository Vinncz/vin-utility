import Foundation



/// A collection of values that represents one axis of a size, in accordance with IBM's Carbon Design System.
indirect public enum VUViewSize : VUAssociableWithValue {
    
    
    /// Represents the an infinitely small size.
    case none
    
    
    /// Represents 1 point of size in some axis.
    case xxxSmall
    
    
    /// Represents 2 points of size in some axis.
    case xxSmall
    
    
    /// Represents 4 points of size in some axis.
    case xSmall
    
    
    /// Represents 8 points of size in some axis.
    case small
    
    
    /// Represents 12 points of size in some axis.
    case normal
    
    
    /// Represents 16 points of size in some axis.
    case medium
    
    
    /// Represents 20 points of size in some axis.
    case big
    
    
    /// Represents 24 points of size in some axis.
    case xBig
    
    
    /// Represents 28 points of size in some axis.
    case xxBig
    
    
    /// Represents 32 points of size in some axis.
    case xxxBig
    
    
    /// Represents a customly defined, unchanging value of size.
    case constant  (CGFloat)
    
    
    /// Represents some sizes put together, resulting in a new value that may not be listed in its source declaration.
    case composite (VUViewSize)
    
    
    /// Associated value of the size.
    public var val: CGFloat {
        switch self {
            case .none      : return 0
            case .xxxSmall  : return 1
            case .xxSmall   : return 2
            case .xSmall    : return 4
            case .small     : return 8
            case .normal    : return 12
            case .medium    : return 16
            case .big       : return 20
            case .xBig      : return 24
            case .xxBig     : return 28
            case .xxxBig    : return 32
            case .constant  (let value)   : return value
            case .composite (let spacing) : return spacing.val
        }
    }
    
}

/// Extension for set sizes of icons.
public extension VUViewSize {
    
    
    /// Used for sizing icons. Equates to ``VUViewSize/medium``.
    static var iCallout: VUViewSize = .medium
    
    
    /// Used for sizing icons. Equates to ``VUViewSize/big``.
    static var iBody: VUViewSize = .big
    
    
    /// Used for sizing icons. Equates to ``VUViewSize/big`` + ``VUViewSize/xxSmall``.
    static var iHeadline: VUViewSize = .composite(.big + .xxSmall)
    
    
    /// Used for sizing icons. Equates to ``VUViewSize/xxBig`` + ``VUViewSize/xxSmall``.
    static var iTitle: VUViewSize = .composite(.xxBig + .xxSmall)
    
    
    /// Used for sizing icons. Equates to ``VUViewSize/xBig`` + ``VUViewSize/normal`` + ``VUViewSize/xxSmall``.
    static var iLargeTitle: VUViewSize = .composite(.xBig + .normal + .xxSmall)
    
}



/// Extensions for set sizes of container breakpoints.
public extension VUViewSize {
    
    
    /// Used as width-clamping constants. Equates to 393 points.
    static var cCompact: VUViewSize = .constant(393)
    
    
    /// Used as width-clamping constants. Equates to 768 points.
    static var cLoose: VUViewSize = .constant(768)
    
    
    /// Used as width-clamping constants. Equates to 1080 points.
    static var cWide: VUViewSize = .constant(1080)
    
}



/// Conformance to `AdditiveArithmetic` public protocol.
extension VUViewSize : AdditiveArithmetic {
    
    
    /// Represents 0 points of size in some axis.
    public static var zero: VUViewSize {
        return .none
    }
    
    
    /// Adds two sizes together.
    public static func + (lhs: VUViewSize, rhs: VUViewSize) -> VUViewSize {
        return .constant(lhs.val + rhs.val)
    }
    
    
    /// Subtracts two sizes.
    public static func - (lhs: VUViewSize, rhs: VUViewSize) -> VUViewSize {
        return .constant(lhs.val - rhs.val)
    }
    
}



extension VUViewSize {
    
    
    /// Multiplies two sizes together.
    public static func * (lhs: VUViewSize, rhs: VUViewSize) -> VUViewSize {
        return .constant(lhs.val * rhs.val)
    }
    
    
    /// Multiplies a size by a scalar.
    public static func * (lhs: VUViewSize, rhs: CGFloat) -> VUViewSize {
        return .constant(lhs.val * rhs)
    }
    
    
    /// Divides two sizes.
    public static func / (lhs: VUViewSize, rhs: VUViewSize) -> VUViewSize {
        return .constant(lhs.val / rhs.val)
    }
    
    
    /// Divides a size by a scalar.
    public static func / (lhs: VUViewSize, rhs: CGFloat) -> VUViewSize {
        return .constant(lhs.val / rhs)
    }
    
}

extension VUViewSize : Equatable {
    
    
    public static func == (lhs: VUViewSize, rhs: VUViewSize) -> Bool {
        return lhs.val == rhs.val
    }
    
    
    public static func != (lhs: VUViewSize, rhs: VUViewSize) -> Bool {
        return lhs.val != rhs.val
    }
    
}

extension VUViewSize : Comparable {
    
    
    public static func < (lhs: VUViewSize, rhs: VUViewSize) -> Bool {
        return lhs.val < rhs.val
    }
    
    
    public static func > (lhs: VUViewSize, rhs: VUViewSize) -> Bool {
        return lhs.val > rhs.val
    }
    
    
    public static func <= (lhs: VUViewSize, rhs: VUViewSize) -> Bool {
        return lhs.val <= rhs.val
    }
    
    
    public static func >= (lhs: VUViewSize, rhs: VUViewSize) -> Bool {
        return lhs.val >= rhs.val
    }
    
}
