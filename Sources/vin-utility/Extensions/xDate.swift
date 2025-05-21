import Foundation



public extension Date {
    
    
    /// Parses a string into a Date object without throwing an error.
    /// 
    /// - Parameter dateString: The string representation of the date.
    /// - Parameter format: The date format to use for parsing. Defaults to "yyyy-MM-dd'T'HH:mm:ssZ".
    /// - Returns: An optional Date object if parsing is successful, or nil if it fails.
    static func parse(_ dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
}
