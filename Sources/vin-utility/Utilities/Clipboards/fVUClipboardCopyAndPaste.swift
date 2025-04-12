import Foundation

#if os(macOS)
import AppKit

/// Copy the specified content to the clipboard.
@discardableResult public func VUCopyToClipboard(_ input: Any) -> Bool {
    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()

    if let string = input as? String {
        pasteboard.setString(string, forType: .string)
        
    } else if let image = input as? NSImage {
        if let imageData = image.tiffRepresentation {
            pasteboard.setData(imageData, forType: .tiff)
        }
        
    } else if let fileURL = input as? URL {
        pasteboard.writeObjects([fileURL] as [NSPasteboardWriting])
        
    } else {
        return false
        
    }
    
    return true
}

/// Paste content from the clipboard.
public func VUPasteFromClipboard() -> Any? {
    let pasteboard = NSPasteboard.general

    if let string = pasteboard.string(forType: .string) {
        return string
        
    } else if let imageData = pasteboard.data(forType: .tiff),
              let image = NSImage(data: imageData) {
        return image
        
    } else if let fileURLs = pasteboard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL], !fileURLs.isEmpty {
        return fileURLs.first
        
    } else if let urlString = pasteboard.string(forType: .string), let url = URL(string: urlString) {
        return url
    }
    
    return nil
}


#elseif os(iOS) || os(iPadOS)
import UIKit

/// Copy the specified content to the clipboard.
@discardableResult public func VUCopyToClipboard(_ input: Any) -> Bool {
    let pasteboard = UIPasteboard.general

    if let string = input as? String {
        pasteboard.string = string
        
    } else if let image = input as? UIImage {
        pasteboard.image = image
        
    } else if let fileURL = input as? URL {
        let item: [String: Any] = [UIPasteboard.typeAutomatic: fileURL]
        pasteboard.setItems([item])
        
    } else if let url = input as? URL {
        pasteboard.url = url
        
    } else {
        return false
        
    }
    
    return true
}

/// Paste content from the clipboard.
public func VUPasteFromClipboard() -> Any? {
    let pasteboard = UIPasteboard.general

    if let string = pasteboard.string {
        return string
        
    } else if let image = pasteboard.image {
        return image
        
    } else if let fileURL = pasteboard.items.first(where: { $0[UIPasteboard.typeAutomatic] != nil })?[UIPasteboard.typeAutomatic] as? URL {
        return fileURL
        
    } else if let url = pasteboard.url {
        return url
    }
    
    return nil
}

#endif
