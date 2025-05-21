import Foundation
import CoreLocation



/// Type that provides access to the device's current geolocation coordinates.
/// 
/// Use the ``VULocationBeacon`` class to conveniently extracts a device's current location.
/// 
/// Due to the unforeseen trouble that may happen in gathering, refreshing, and calculating the
/// location, this class is designed to be used in a monadic way. 
/// 
/// - Note: Ensure that the app has the appropriate location permissions configured in the
///         Info.plist file and that the user has granted location access.
/// 
/// Example usage:
/// ```swift
/// let locationBeacon = VULocationBeacon()
/// locationBeacon.locate { result in
///     switch result {
///     case .success(let coordinate):
///         print("Latitude: \(coordinate.latitude), Longitude: \(coordinate.longitude)")
///     case .failure(let error):
///         print("Failed to get location: \(error)")
///     }
/// }
/// ```
public final class VULocationBeacon: NSObject {
    
    
    /// The location manager used to manage location updates.
    private var locationManager: CLLocationManager
    
    
    /// Collection of closures that are to be executed when the location is retrieved or an error occurs.
    private var completions: [(Result<CLLocationCoordinate2D, VUError>) -> Void]
    
    
    /// The thread-safe queue used to synchronize access to the completions array.
    private let queue = DispatchQueue(label: "com.vin-utility.location-beacon.queue")
    
    
    /// A shared instance of `VULocationBeacon` for convenient access.
    /// 
    /// Use this shared instance to avoid creating multiple instances of `VULocationBeacon`.
    public static var shared = VULocationBeacon() 
    
    
    /// Initializes a new instance of `VULocationBeacon` with the specified accuracy.
    /// 
    /// - Parameter accuracy: The desired accuracy for location updates. Defaults to `kCLLocationAccuracyNearestTenMeters`.
    /// - Note: This initializer configures the location manager and requests location permissions.
    public init(accuracy: CLLocationAccuracy = kCLLocationAccuracyNearestTenMeters) {
        let locationManager = CLLocationManager()
        self.locationManager = locationManager
        
        self.completions = []
        super.init()
        
        locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = accuracy
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    
    /// Retrieves the current location of the device.
    /// 
    /// This method requests the location from the underlying CoreLocationManager, and provide the result through a completion handler.
    /// 
    /// - Parameter completion: A closure that handles the result of the location request. The result is either a success with the user's coordinates or a failure with an error.
    /// - Note: Ensure that location permissions are granted before calling this method.
    public func locate(completion: @escaping (Result<CLLocationCoordinate2D, VUError>) -> Void, line: Int = #line, file: String = #file) {
        queue.sync {
            self.completions.append(completion)
        }
        
        self.locationManager.requestLocation()
    }
    
}



extension VULocationBeacon: CLLocationManagerDelegate {
    
    
    /// Called when the location manager successfully retrieves location updates.
    /// 
    /// - Parameters:
    ///   - manager: The location manager providing the updates.
    ///   - locations: An array of `CLLocation` objects representing the user's location.
    /// - Note: Only the first location in the array is used, and the completion handler is called with the result.
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        
        queue.sync {
            let completionsCopy = self.completions
            self.completions.removeAll()
            
            completionsCopy.forEach { completion in
                completion(.success(coordinate))
            }
        }
    }
    
    
    /// Called when the location manager encounters an error during location updates.
    /// 
    /// - Parameters:
    ///   - manager: The location manager reporting the error.
    ///   - error: The error encountered during location updates.
    /// - Note: The completion handler is called with a failure result containing the error.
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        queue.sync {
            let completionsCopy = self.completions
            self.completions.removeAll()
            
            completionsCopy.forEach { completion in
                completion(.failure(.LocationDomainError(underlying: error)))
            }
        }
    }
    
}
