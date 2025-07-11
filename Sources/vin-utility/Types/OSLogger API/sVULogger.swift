import Foundation
import os

public struct VULogger {
    
    
    static private var loggerPool: [String: Logger] = [:]
    
    
    static public func log (
        tag      : VULogTag = .log, 
        _ items  : Any...,
        file     : String = #file,
        initiator: String = #function,
        line     : Int    = #line,
        column   : Int    = #column,
        separator: String = " "
    ) {
        #if DEBUG
            let shortFileName = URL(string: file)?.lastPathComponent ?? "---"
            
            let output = items.map {
                return if let itm = $0 as? CustomStringConvertible {
                    "\(itm.description)"
                } else {
                    "\($0)"
                }
            }.joined(separator: separator)
            
            let category = "\(shortFileName) • \(initiator) on line \(line), column \(column)"
            var msg      = "\(tag.label(category: category)) "
        
            if !output.isEmpty { msg += "\n\(output)" }
            
            DispatchQueue.main.async {
                if let logger = loggerPool["\(Bundle.main.bundleIdentifier ?? "--")&&\(category)"] {
                    actuallyLogTheThing(tag: tag, logger: logger, message: msg)
                } else {
                    let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "--", category: category)
                    loggerPool["\(Bundle.main.bundleIdentifier ?? "--")&&\(category)"] = logger
                    actuallyLogTheThing(tag: tag, logger: logger, message: msg)
                }
            }
        #endif
    }
    
}

public enum VULogTag {
    
    case critical
    case error
    case warning
    case success
    case debug
    case network
    case simOnly
    case log
    
    public func label(category: String = "") -> String {
        switch self {
            case .critical: return "🚨 CRITICAL-- \(category)"
            case .error   : return "🔴 ERROR-- \(category)"
            case .warning : return "🟠 WARNING-- \(category)"
            case .success : return "🟢 SUCCESS-- \(category)"
            case .debug   : return "🔵 DEBUG-- \(category)"
            case .network : return "🌍 NETWORK-- \(category)"
            case .simOnly : return "🤖 SIM-EXCL-- \(category)"
            case .log     : return "🔹 LOG-- \(category)"
        }
    }
    
}



fileprivate func actuallyLogTheThing(tag: VULogTag, logger: Logger, message msg: String) {
    switch tag {
        case .critical: logger.critical("\(msg)")
        case .error   : logger.error  ("\(msg)")
        case .warning : logger.warning("\(msg)")
        case .success : logger.info   ("\(msg)")
        case .debug   : logger.debug  ("\(msg)")
        case .network : logger.info   ("\(msg)")
        case .simOnly : logger.info   ("\(msg)")
        case .log     : logger.log    ("\(msg)")
    }
}
