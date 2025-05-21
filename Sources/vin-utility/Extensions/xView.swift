#if canImport(SwiftUI)
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif


public extension View {
    
    
    func border ( _ edges: Edge.Set, _ color: Color, girth: CGFloat ) -> some View {
        overlay (
            EdgeBorder(edges: edges, color: color, girth: girth)
        )
    }
    
    
    #if canImport(UIKit)
    func keyboardDismissableByTappingNearlyAnywhere () -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction (
                #selector(UIResponder.resignFirstResponder),
                to  : nil,
                from: nil,
                for : nil
            )
        }
    }
    #endif
    
}

public struct EdgeBorder : View {
    
    
    public let edges : Edge.Set
    
    
    public let color : Color
    
    
    public let girth : CGFloat
    
    
    public var body : some View {
        GeometryReader { geometry in
            ZStack {
                if edges.contains(.top) {
                    color
                        .frame(height: girth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                
                if edges.contains(.bottom) {
                    color
                        .frame(height: girth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                
                if edges.contains(.leading) {
                    color
                        .frame(width: girth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                
                if edges.contains(.trailing) {
                    color
                        .frame(width: girth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

#endif
