//
//  LocationModel.swift
//  Stubet
//
//  Created by KJ on 9/4/24.
//

import Foundation
import CoreLocation

struct Location {
    let name: String        // Name of the location
    let address: String     // Address of the location
    let latitude: Double    // Latitude of the location
    let longitude: Double   // Longitude of the location

    // Initialize from Firebase document data
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.address = data["address"] as? String ?? ""
        self.latitude = data["latitude"] as? Double ?? 0.0
        self.longitude = data["longitude"] as? Double ?? 0.0
    }
    
    // Convert latitude and longitude to CLLocation for proximity checks
    var clLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
