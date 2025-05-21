import SwiftUI

/// Performs a haptic feedback upon touch down and/or long press.
struct VUTouchFeedbackHapticArea <Children: View> : View {
    
    let children       : Children
    let onTouchDown    : ( () -> Void )?
    let strength       : UIImpactFeedbackGenerator.FeedbackStyle
    let triggerDuration: Double
    
    init (
        strength   : UIImpactFeedbackGenerator.FeedbackStyle = .light,
        onTouchDown: ( () -> Void )? = nil,
        @ViewBuilder children: () -> Children
    ) {
        self.children        = children()
        self.strength        = strength
        self.triggerDuration = 0.1
        self.onTouchDown     = onTouchDown
    }
    
    var body : some View {
        children
            .modifier (
                HapticFeedbackModifier (
                    strength        : strength, 
                    triggerDuration : triggerDuration,
                    onTouchDown     : onTouchDown
                )
            )
    }
    
}

/// A view modifier that adds haptic feedback to a view upon touch down and/or long press.
struct HapticFeedbackModifier : ViewModifier {
    
    let strength       : UIImpactFeedbackGenerator.FeedbackStyle
    let triggerDuration: Double
    let onTouchDown    : ( () -> Void )?
    
    init (
        strength       : UIImpactFeedbackGenerator.FeedbackStyle = .light, 
        triggerDuration: Double = 0.25,
        onTouchDown    : (() -> Void)? = nil
    ) {
        self.strength        = strength
        self.triggerDuration = triggerDuration
        self.onTouchDown     = onTouchDown
    }
    
    func body ( content: Content ) -> some View {
        content
            .simultaneousGesture (
                TapGesture()
                    .onEnded { _ in
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: strength)
                        feedbackGenerator.prepare()
                        feedbackGenerator.impactOccurred()
                        
                        onTouchDown?()
                    }
            )
            .simultaneousGesture (
                LongPressGesture(minimumDuration: triggerDuration)
                    .onEnded { _ in
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: strength)
                        feedbackGenerator.prepare()
                        feedbackGenerator.impactOccurred()
                        
                        onTouchDown?()
                    }
            )
            .contentShape(Rectangle())
    }
    
}
