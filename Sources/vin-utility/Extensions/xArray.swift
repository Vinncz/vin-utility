import Foundation



public extension Array where Element: StringProtocol {
    
    
    /// Coalesces the array of strings into a single string, separated by the given separator.
    /// 
    /// - Parameter separator: The separator to use between the strings. Defaults to a comma.
    /// - Returns: A single string containing all the elements of the array, separated by the given separator.
    func coalesce(separator: String = ", ") -> String {
        return self.joined(separator: separator)
    }
    
}



public extension Array where Element: AnyObject {
    
    
    /// Returns the first index of the given element in the array, or nil if not found.
    /// 
    /// - Parameter element: The element to search for.
    /// - Returns: The index of the first occurrence of the element, or nil if not found.
    func firstIndex(of element: Element) -> Int? {
        return self.firstIndex(where: { $0 === element })
    }
    
}



public extension Array where Element: Hashable {
    
    
    /// Returns the first index of the given element in the array, or nil if not found.
    /// 
    /// - Parameter element: The element to search for.
    /// - Returns: The index of the first occurrence of the element, or nil if not found.
    func firstIndex(of element: Element) -> Int? {
        return self.firstIndex(where: { $0 == element })
    }
    
}



public extension Array where Element: Equatable {
    
    
    /// Returns the first index of the given element in the array, or nil if not found.
    /// 
    /// - Parameter element: The element to search for.
    /// - Returns: The index of the first occurrence of the element, or nil if not found.
    func firstIndex(of element: Element) -> Int? {
        for (index, item) in self.enumerated() {
            if item == element {
                return index
            }
        }
        return nil
    }
    
}
