#if os(iOS)
import AVFoundation
import Foundation
import os
import SwiftUI

@available(iOS 17.0, *)
public struct VUScannerView : VUConfigurable, UIViewControllerRepresentable {
    
    public var isScanning: Binding<Bool>?
    public var config  : confdt
    public var callback: ((String) -> Void)?
    public var error   : Binding<String>?
    
    public init ( 
        _ incomingConfig: confdt = [:], 
          error         : Binding<String>?, 
          isScanning    : Binding<Bool>?,
        _ callback      : ((String) -> Void)? = nil
    ) {
        self.error    = error
        self.callback = callback
        self.isScanning = isScanning
        
        self.config = VUMergeDictionaries(defaultConfig, incomingConfig)
    }
    
    public func makeUIViewController ( context: Context ) -> VUScannerViewController {
        let controller      = VUScannerViewController(config, error: error)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    public func makeCoordinator () -> Coordinator {
        Coordinator(config, error, callback)
    }
    
    public func updateUIViewController ( _ uiViewController: VUScannerViewController, context: Context ) {
        if let isScanning {
            isScanning.wrappedValue ? 
                DispatchQueue.global().async { uiViewController.captureSession.startRunning() }
                : DispatchQueue.global().async { uiViewController.captureSession.stopRunning() }
        } 
    }
    
    let defaultConfig : confdt = [
        .debounce        : .wrap(0.25),
        .captureMode     : .wrap(CaptureMode.continuous),
        .recognizedTypes : .wrap([AVMetadataObject.ObjectType.qr]),
        .cameraPriority  : .wrap([AVCaptureDevice.DeviceType.builtInWideAngleCamera, AVCaptureDevice.DeviceType.external, AVCaptureDevice.DeviceType.continuityCamera])
    ]
}

@available(iOS 17.0, *)
extension VUScannerView {
    
    public class Coordinator : NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var config  : confdt
        var callback: ((String) -> Void)?
        var error   : Binding<String>?
        
        var lastExecution : Date = .distantPast
        var hasBeenExecuted : Bool = false
        
        init ( 
            _ config  : confdt,
            _ error   : Binding<String>?,
            _ callback: ((String) -> Void)? 
        ) {
            self.config   = config
            self.error    = error
            self.callback = callback
        }
        
        public func metadataOutput (
            _         output         : AVCaptureMetadataOutput, 
            didOutput metadataObjects: [AVMetadataObject], 
            from      connection     : AVCaptureConnection
        ) {
            guard 
                Date.now >= lastExecution.addingTimeInterval(config[.debounce]!.take(as: TimeInterval.self)!),
                metadataObjects.count > 0 
            else { return }
            
            self.lastExecution = .now
            
            if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if let recognizedTypes = config[.recognizedTypes]?.take(as: [AVMetadataObject.ObjectType.self]) {
                    if recognizedTypes.contains(metadataObj.type), let result = metadataObj.stringValue {
                        if .singleScan == config[.captureMode]?.take(as: CaptureMode.self) && hasBeenExecuted
                        { return }
                        
                        self.hasBeenExecuted = true
                        callback?(result)
                        
                    } else {
                        error?.wrappedValue = "Unrecognized type: \(metadataObj.type)"
                        return
                    }
                    
                } else {
                    error?.wrappedValue = "Unable to understand the config's recognizedTypes: \(String(describing: config[.recognizedTypes]))"
                    return
                }
                
            } else {
                error?.wrappedValue = "Unable to convert metadataObjects[0] to AVMetadataMachineReadableCodeObject"
                return
            }
        }
    }
    
}

@available(iOS 17.0, *)
public extension VUScannerView {
    
    public enum CaptureMode {
        case singleScan
        case continuous
    }
    
}

@available(iOS 17.0, *)
public extension VUScannerView {
    
    public enum Config {
        case captureMode
        case debounce
        case cameraPriority
        case recognizedTypes
    }
    
    typealias confdt = [Config: VUTypeWrapper<Any>]
    
}

#elseif os(macOS)
import AVFoundation
import Foundation
import os
import SwiftUI
import AppKit

@available(macOS 14.0, *)
public struct VUScannerView: VUConfigurable, NSViewControllerRepresentable {

    public var isScanning: Binding<Bool>?
    public var config: confdt
    public var callback: ((String) -> Void)?
    public var error: Binding<String>?

    public init(
        _ incomingConfig: confdt = [:],
        error: Binding<String>?,
        isScanning: Binding<Bool>?,
        _ callback: ((String) -> Void)? = nil
    ) {
        self.error = error
        self.callback = callback
        self.isScanning = isScanning
        self.config = VUMergeDictionaries(defaultConfig, incomingConfig)
    }

    public func makeNSViewController(context: Context) -> VUScannerViewController {
        let controller = VUScannerViewController(config, error: error)
        controller.delegate = context.coordinator
        return controller
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(config, error, callback)
    }

    public func updateNSViewController(_ nsViewController: VUScannerViewController, context: Context) {
        if let isScanning {
            isScanning.wrappedValue ?
                DispatchQueue.global().async { nsViewController.captureSession.startRunning() }
                : DispatchQueue.global().async { nsViewController.captureSession.stopRunning() }
        }
    }

    let defaultConfig: confdt = [
        .debounce: .wrap(0.25),
        .captureMode: .wrap(CaptureMode.continuous),
        .recognizedTypes: .wrap([AVMetadataObject.ObjectType.qr]),
        .cameraPriority: .wrap([AVCaptureDevice.DeviceType.builtInWideAngleCamera, AVCaptureDevice.DeviceType.external, AVCaptureDevice.DeviceType.continuityCamera])
    ]
}

@available(macOS 14.0, *)
extension VUScannerView {

    public class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        public var config: confdt
        public var callback: ((String) -> Void)?
        public var error: Binding<String>?

        public var lastExecution: Date = .distantPast
        public var hasBeenExecuted: Bool = false

        public init(
            _ config: confdt,
            _ error: Binding<String>?,
            _ callback: ((String) -> Void)?
        ) {
            self.config = config
            self.error = error
            self.callback = callback
        }

        public func metadataOutput(
            _ output: AVCaptureMetadataOutput,
            didOutput metadataObjects: [AVMetadataObject],
            from connection: AVCaptureConnection
        ) {
            guard
                Date.now >= lastExecution.addingTimeInterval(config[.debounce]!.take(as: TimeInterval.self)!),
                metadataObjects.count > 0
            else { return }

            self.lastExecution = .now

            if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if let recognizedTypes = config[.recognizedTypes]?.take(as: [AVMetadataObject.ObjectType.self]) {
                    if recognizedTypes.contains(metadataObj.type), let result = metadataObj.stringValue {
                        if .singleScan == config[.captureMode]?.take(as: CaptureMode.self) && hasBeenExecuted {
                            return
                        }

                        self.hasBeenExecuted = true
                        callback?(result)

                    } else {
                        error?.wrappedValue = "Unrecognized type: \(metadataObj.type)"
                        return
                    }

                } else {
                    error?.wrappedValue = "Unable to understand the config's recognizedTypes: \(String(describing: config[.recognizedTypes]))"
                    return
                }

            } else {
                error?.wrappedValue = "Unable to convert metadataObjects[0] to AVMetadataMachineReadableCodeObject"
                return
            }
        }
    }

}

@available(macOS 14.0, *)
public extension VUScannerView {

    enum CaptureMode {
        case singleScan
        case continuous
    }

}

@available(macOS 14.0, *)
public extension VUScannerView {

    enum Config {
        case captureMode
        case debounce
        case cameraPriority
        case recognizedTypes
    }

    typealias confdt = [Config: VUTypeWrapper<Any>]

}

#endif
