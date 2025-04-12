import Foundation



/// The base type for all services.
public protocol VUServicing {}



/// Services which maintain an internal state or context.
/// 
/// Conformance to this public protocol is decorative; marking the service
/// as stateful. It does not enforce any specific behavior or
/// implementation details.
public protocol VUStatefulServicing: VUServicing, AnyObject {}



/// Services which does not maintain an internal state or context.
/// 
/// Conformance to this public protocol is decorative; marking the service
/// as stateless. It does not enforce any specific behavior or
/// implementation details.
public protocol VUStatelessServicing: VUServicing {}



/// Services which precede other services that may depend on them.
/// Possesses an inert behavior until some condition is fulfilled.
public protocol VUAntecedentServicing: VUServicing {}



/// Services which are compatible with being transitioned to,
/// and continue on the responsibility of another service.
public protocol VUTransitionCompatibleServicing: VUServicing {}



/// Services which operates at a transitional or intermediate stage;
/// facilitating the handover of its state, responsibility, or public functionality
/// to another service once its role is fulfilled.
/// 
/// Conformance to this public protocol requires your service to be able to gracefully
/// manage transitions, ensuring continuity and consistency.
public protocol VULiminalServicing: VUServicing {
    
    
    /// The service that will take over the responsibility once this service
    /// has completed its task.
    var nextService: VUTransitionCompatibleServicing? { get set }
    
    
    /// Initiates the transition to the next service.
    func transitionToNextService()
    
    
    /// Handles any cleanup or finalization before transitioning.
    func finalizeTransition()
    
}
