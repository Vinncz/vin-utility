#if canImport(UIKit)
import SwiftUI
import UIKit

public struct VUPullToDismissScrollView <Content: View>: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var dragOffset       : CGFloat = 0
    @State private var lastHapticTrigger: CGFloat = 0
    @State private var isAtTop          : Bool    = true
    @State private var canTriggerHaptic : Bool    = true
    
    public let behavior: VUPullToDismissBehavior
    public let content : () -> Content
    
    public init ( 
        behavior: VUPullToDismissBehavior = .normal, 
        @ViewBuilder content: @escaping () -> Content 
    ) {
        self.behavior = behavior
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            Sensor()
            VStack {
                Indicator()
                    .padding(.top, 3 * -VUViewSize.big.val)
                content()
            }
            .background(.black.opacity(0.0005))
            .simultaneousGesture (
                DragGesture()
                    .onChanged { gesture in
                        if isAtTop {
                            let translation = gesture.translation.height
                            let pullingDown = translation > 0
                            
                            if pullingDown {
                                dragOffset = behavior.resistance(for: translation)
                                suggestHaptic(for: dragOffset)
                                
                            } else {
                                dragOffset = max(0, dragOffset + translation * 0.5)
                                
                            }
                        }
                    }
                    .onEnded { gesture in
                        if isAtTop {
                            if gesture.translation.height > behavior.triggerThreshold {
                                dragOffset = 0
                                dismiss()
                            } else {
                                withAnimation(.interpolatingSpring(stiffness: behavior.stiffness, damping: behavior.damping)) {
                                    dragOffset = 0
                                }
                            }
                            
                            lastHapticTrigger = 0
                        }
                    }
            )
        }
    }
    
    // Detects if user has scrolled to the top
    private func checkIfAtTop ( proxy: GeometryProxy ) {
        isAtTop = proxy.frame(in: .global).minY >= 0
    }
    
    
    /// Attempts to make a haptic feedback from the given offset, in relation to the set ``behavior`` object.
    private func suggestHaptic ( for offset: CGFloat ) {
        let step = behavior.triggerThreshold / behavior.hapticTriggerZoneCount
        let shouldTrigger = abs(offset - lastHapticTrigger) > step
        
        if shouldTrigger && canTriggerHaptic {
            let feedback = UIImpactFeedbackGenerator(style: .soft)
            feedback.impactOccurred(intensity: behavior.hapticIntensityFromZeroToOne)
            
            lastHapticTrigger = offset
            canTriggerHaptic = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + behavior.hapticDebounceInSeconds) {
                canTriggerHaptic = true
            }
        }
    }
}


/// 
public struct VUPullToDismissBehavior {
    
    public var triggerThreshold            : CGFloat
    public var pullResistanceRatio         : Double
    public var stiffness                   : CGFloat
    public var damping                     : CGFloat
    public var hapticTriggerZoneCount      : CGFloat
    public var hapticIntensityFromZeroToOne: CGFloat
    public var hapticDebounceInSeconds     : Double
    
    public static var normal = VUPullToDismissBehavior (
        triggerThreshold            : 250,
        pullResistanceRatio         : 0.7,
        stiffness                   : 180,
        damping                     : 20,
        hapticTriggerZoneCount      : 20,
        hapticIntensityFromZeroToOne: 1,
        hapticDebounceInSeconds     : 0.1
    )
    
    public func resistance ( for pullDistance: CGFloat ) -> CGFloat {
        return pullDistance * pullResistanceRatio
    }
    
}


/// 
public extension VUPullToDismissScrollView {
    
    @ViewBuilder func Indicator () -> some View {
        Text(dragOffset > behavior.triggerThreshold ? "Release to dismiss" : "Pull down to dismiss")
            .foregroundColor(.secondary)
            .scaleEffect(scaleEffectCalculator())
            .opacity(opacityEffectCalculator())
            .offset(y: offsetEffectCalculator())
            .animation(.easeOut(duration: 0.2), value: dragOffset)
    }
    
    @ViewBuilder func Sensor () -> some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    checkIfAtTop(proxy: proxy)
                }
                .onChange(of: proxy.frame(in: .global).minY) { _, _ in
                    checkIfAtTop(proxy: proxy)
                }
        }
            .frame(height: 0)
    }
    
}


/// 
public extension VUPullToDismissScrollView {
    
    private func opacityEffectCalculator() -> Double {
        dragOffset / behavior.triggerThreshold
    }
    
    private func scaleEffectCalculator() -> CGFloat {
        let desiredValue = dragOffset / behavior.triggerThreshold + 0.1
        return if desiredValue < 1 {
            desiredValue
        } else {
            1
        }
    }
    
    private func offsetEffectCalculator() -> CGFloat {
        behavior.offsetBase + dragOffset * behavior.offsetMultiplier
    }
}

public extension VUPullToDismissBehavior {
    
    var offsetBase: CGFloat { -60 }
    var offsetMultiplier: CGFloat { 0.2 }
    
}
#endif
