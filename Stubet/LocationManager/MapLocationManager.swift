//
//  LocationManager.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import Foundation
import CoreLocation
import MapKit

class MapLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region: MKCoordinateRegion
    
    private let locationManager = CLLocationManager()
    
    override init() {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917), // Default region (Tokyo)
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func searchLocation(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks, let location = placemarks.first?.location {
                let coordinate = location.coordinate
                DispatchQueue.main.async {
                    self.region.center = coordinate
                    completion(coordinate)
                }
            } else {
                print("Error finding location: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
}


