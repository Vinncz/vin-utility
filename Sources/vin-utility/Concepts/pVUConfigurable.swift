import Foundation

/// A type that represents something that can be configured, or has an implementation of a configuration.
protocol VUConfigurable {
    
    /// The facade type that represents the configuration.
    associatedtype Config
    
}
