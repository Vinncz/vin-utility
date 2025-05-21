import SwiftUI

/// Draws a border around its children upon touch down or hold events.
struct VUTouchDownModifierDrawBorder <Children: View> : View {
    
    let animationDuration: Double
    let borderColor      : Color
    let borderEdges      : Edge.Set
    let borderWidth      : CGFloat
    let children         : Children
    
    @State private var isPressed: Bool = false
    
    init (
        color   : Color    = .primary,
        girth   : CGFloat  = 2,
        edges   : Edge.Set = .all,
        duration: Double   = 0.2,
        @ViewBuilder children: () -> Children
    ) {
        self.borderColor = color
        self.borderWidth = girth
        self.borderEdges = edges
        self.animationDuration = duration
        self.children = children()
    }
    
    var body : some View {
        children
            .overlay {
                if isPressed {
                    EdgeBorder(edges: borderEdges, color: borderColor, girth: borderWidth)
                }
            }
            .simultaneousGesture (
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
            .animation(.easeInOut(duration: animationDuration), value: isPressed)
    }
    
}
