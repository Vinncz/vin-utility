import SwiftUI

/// Scales its children a certain factor upon a touch down or hold events.
struct VUTouchFeedbackScaleArea <Children: View> : View {
    
    let animationDuration: Double
    let content          : Children
    let scaleFactor      : CGFloat

    @State private var isPressed: Bool = false

    init (
        scaleFactor         : CGFloat = 0.98,
        animationDuration   : Double = 0.2,
        @ViewBuilder content: () -> Children
    ) {
        self.scaleFactor = scaleFactor
        self.animationDuration = animationDuration
        self.content = content()
    }

    var body: some View {
        content
            .contentShape(Rectangle())
            .scaleEffect(isPressed ? scaleFactor : 1.0)
            .animation(.easeInOut(duration: animationDuration), value: isPressed)
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
    }

}

