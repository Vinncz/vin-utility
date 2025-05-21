import Foundation



/// Converts a `TimeInterval` (in seconds) to a human-readable duration string.
/// Ranges from a second to a year; appending the leftovers.
/// 
/// Example:
/// `VUSecondsToDurationConverter.convert(3661)`
/// returns "1 hour, 1 minute, 1 second".
public func VUSecondsToDurationConverter(_ seconds: TimeInterval) -> String {
    let timeUnits: [(String, TimeInterval)] = [
        ("year", 365 * 24 * 60 * 60),
        ("month", 30 * 24 * 60 * 60),
        ("day", 24 * 60 * 60),
        ("hour", 60 * 60),
        ("minute", 60),
        ("second", 1)
    ]
    
    var remainingSeconds = seconds
    var components: [String] = []
    
    for (unitName, unitValue) in timeUnits {
        let unitCount = Int(remainingSeconds / unitValue)
        if unitCount > 0 {
            components.append("\(unitCount) \(unitName)\(unitCount > 1 ? "s" : "")")
            remainingSeconds -= TimeInterval(unitCount) * unitValue
        }
    }
    
    return components.joined(separator: ", ")
}

