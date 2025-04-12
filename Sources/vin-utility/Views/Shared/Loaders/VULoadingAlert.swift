#if os(iOS)
import UIKit

public func VUPresentLoadingAlert(on viewController: UIViewController?, title: String, message: String, cancelButtonCTA: String, delay: TimeInterval, cancelAction: (() -> Void)?) {
    let alert = UIAlertController(title: title, message: "\(message)\n\n\n", preferredStyle: .alert)

    let cancelAction = UIAlertAction(title: cancelButtonCTA, style: .cancel) { _ in cancelAction?() }
    cancelAction.isEnabled = false
    alert.addAction(cancelAction)

    let spinner = UIActivityIndicatorView(style: .large)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    
    alert.view.addSubview(spinner)

    NSLayoutConstraint.activate([
        spinner.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
        spinner.centerYAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -80)
    ])

    viewController?.present(alert, animated: true)

    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        cancelAction.isEnabled = true
    }
}

public class PreviewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            VUPresentLoadingAlert(on: self, 
                                  title: "Talking to server..", 
                                  message: "You won't lose any progress if you cancel this.", 
                                  cancelButtonCTA: "Nevermind that", 
                                  delay: 5, 
                                  cancelAction: {
                                      print("hello")
                                  }
            )
        }
    }
    
}

#elseif os(macOS)
import AppKit

public func VUPresentLoadingAlert(on viewController: NSViewController?, title: String, message: String, cancelButtonCTA: String, delay: TimeInterval, cancelAction: (() -> Void)?) {
    let alert = NSAlert()
    alert.messageText = title
    alert.informativeText = "\(message)\n\n\n"

    let cancelButton = alert.addButton(withTitle: cancelButtonCTA)
    cancelButton.isEnabled = false
    
    let spinner = NSProgressIndicator()
    spinner.style = .spinning
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimation(nil)
    
    alert.window.contentView?.addSubview(spinner)
    
    NSLayoutConstraint.activate([
        spinner.centerXAnchor.constraint(equalTo: alert.window.contentView!.centerXAnchor),
        spinner.centerYAnchor.constraint(equalTo: alert.window.contentView!.bottomAnchor, constant: -80)
    ])
    
   if let viewController = viewController {
       if let window = viewController.view.window {
           window.beginSheet(alert.window) { a in
               cancelAction?()
           }
       }
   } else {
       // If no viewController is provided, show it modally
       alert.runModal()
   }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        cancelButton.isEnabled = true
    }
}

public class PreviewController: NSViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            VUPresentLoadingAlert(on: self, 
                                  title: "Talking to server..", 
                                  message: "You won't lose any progress if you cancel this.", 
                                  cancelButtonCTA: "Nevermind that", 
                                  delay: 5, 
                                  cancelAction: {
                                      print("hello")
                                  }
            )
        }
    }
}

#endif
