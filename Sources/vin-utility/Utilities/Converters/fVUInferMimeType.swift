import UniformTypeIdentifiers

public func VUInferMimeType(for url: URL) -> String {
    if let uti = UTType(filenameExtension: url.pathExtension) {
        return uti.preferredMIMEType ?? "application/octet-stream"
    }
    
    return "application/octet-stream"
}
