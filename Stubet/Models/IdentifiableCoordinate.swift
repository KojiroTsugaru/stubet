//
//  IdentifiableCoordinate.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import Foundation
import CoreLocation

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()  // This ensures each coordinate is unique
    let coordinate: CLLocationCoordinate2D
}
