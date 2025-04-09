#if os(iOS) || os(iPadOS)
import AVFoundation
import os
import SwiftUI
import UIKit

@available(iOS 17.0, *)
class VUScannerViewController : UIViewController {
    
    var captureSession  = AVCaptureSession()
    
    var previewLayer    : AVCaptureVideoPreviewLayer? = nil
    var delegate        : AVCaptureMetadataOutputObjectsDelegate? = nil
    var qrCodeFrameView : UIView? = nil
    
    var config : [VUScannerView.Config: VUTypeWrapper<Any>]
    var error  : Binding<String>?
    
    init ( _ config: [VUScannerView.Config: VUTypeWrapper<Any>], error: Binding<String>? = nil ) {
        self.config = config
        self.error  = error
        super.init(nibName: nil, bundle: nil)
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews () {
        super.viewDidLayoutSubviews()
        
        if let previewLayer = previewLayer {
            previewLayer.frame = view.bounds
        }
    }
    
    override func viewDidLoad () {
        super.viewDidLoad()
        
        var captureDevice: AVCaptureDevice?
        
        guard let captureDevices = self.config[.cameraPriority]?.take(as: [AVCaptureDevice.DeviceType.self])
        else { fatalError("Unspecified capture devices in the given config object: \(String(describing: self.config[.cameraPriority])).") }
        
        // depletes the array until it finds a working capture device
        // should the back position unavailable, try the front and then unspecified
        for cd in captureDevices {
            captureDevice = .default(cd, for: .video, position: .back) 
            if captureDevice == nil { 
                captureDevice = .default(cd, for: .video, position: .front) 
            }
            if captureDevice == nil { 
                captureDevice = .default(cd, for: .video, position: .unspecified) 
            }
            if captureDevice != nil { break }
        }
        
        guard let captureDevice else {
            DispatchQueue.main.async {
                self.error?.wrappedValue = "Unable to find a suitable capture device."
            }
            
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do { videoInput = try AVCaptureDeviceInput(device: captureDevice) } 
        catch {
            self.error?.wrappedValue = "No input stream. Unable to connect w/ capture device."
            Logger().error("\(error)")
            return
        }
        
        captureSession.addInput(videoInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = config[.recognizedTypes]?.take(as: [AVMetadataObject.ObjectType.self])
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = view.layer.bounds
        
        view.layer.addSublayer(previewLayer!)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
}


#elseif os(macOS)
import AVFoundation
import os
import SwiftUI
import AppKit

@available(macOS 14.0, *)
class VUScannerViewController: NSViewController {

    var captureSession  = AVCaptureSession()
    var previewLayer    : AVCaptureVideoPreviewLayer? = nil
    var delegate        : AVCaptureMetadataOutputObjectsDelegate? = nil
    var qrCodeFrameView : NSView? = nil
    var config : [VUScannerView.Config: VUTypeWrapper<Any>]
    var error  : Binding<String>?

    init(_ config: [VUScannerView.Config: VUTypeWrapper<Any>], error: Binding<String>? = nil) {
        self.config = config
        self.error  = error
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = NSView()  // The root view for this controller
    }

    override func viewDidLayout() {
        super.viewDidLayout()

        if let previewLayer = previewLayer {
            previewLayer.frame = view.bounds
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var captureDevice: AVCaptureDevice?

        // Check the configuration for camera priority
        guard let captureDevices = self.config[.cameraPriority]?.take(as: [AVCaptureDevice.DeviceType.self])
        else { fatalError("Unspecified capture devices in the given config object: \(String(describing: self.config[.cameraPriority])).") }

        // Try to find a working capture device
        for cd in captureDevices {
            captureDevice = .default(cd, for: .video, position: .back)
            if captureDevice == nil {
                captureDevice = .default(cd, for: .video, position: .front)
            }
            if captureDevice == nil {
                captureDevice = .default(cd, for: .video, position: .unspecified)
            }
            if captureDevice != nil { break }
        }

        guard let captureDevice else {
            DispatchQueue.main.async {
                self.error?.wrappedValue = "Unable to find a suitable capture device."
            }
            return
        }

        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            self.error?.wrappedValue = "No input stream. Unable to connect with capture device."
            Logger().error("\(error)")
            return
        }

        captureSession.addInput(videoInput)

        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)

        captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = config[.recognizedTypes]?.take(as: [AVMetadataObject.ObjectType.self])

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = view.layer?.bounds ?? .zero

        if let previewLayer = previewLayer {
            view.layer?.addSublayer(previewLayer)
        }

        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
}


#endif
