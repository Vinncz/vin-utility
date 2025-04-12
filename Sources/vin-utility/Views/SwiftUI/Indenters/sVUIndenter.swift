import SwiftUI

public struct VUIndenterView <Children: View> : View {
    
    let children : Children 
    let level    : IndentationLevel
    let sides    : [Edge.Set]
    
    public init ( 
        _ level: IndentationLevel, 
        affecting sidesAffected: [Edge.Set] = [.leading, .trailing], 
        @ViewBuilder _ children: () -> Children 
    ) {
        self.children = children()
        self.sides    = sidesAffected
        self.level    = level
    }
    
    public var body : some View {
        children
            .padding(sides.reduce([], { $0.union($1) }), (CGFloat(level.rawValue) * VUViewSize.medium.val))
    }
    
}

extension VUIndenterView {
    
    public enum IndentationLevel : Int {
        case none  = 0
        case one   = 1
        case two   = 2
        case three = 3
        case four  = 4
        case five  = 5
    }
    
}
