//
//  AddLocaionViewModel.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import Foundation
import MapKit

class AddLocationViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCoordinates: [IdentifiableCoordinate] = []
    @Published var region: MKCoordinateRegion
    
    private var locationManager = LocationManager()
    
    init() {
        self.region = locationManager.region
        bindLocationUpdates()
    }
    
    private func bindLocationUpdates() {
        locationManager.$region.assign(to: &$region)
    }
    
    func searchForLocation() {
        locationManager.searchLocation(address: searchText) { coordinate in
            guard let coordinate = coordinate else { return }
            self.addCoordinate(coordinate)
        }
    }
    
    func selectLocation(coordinate: CLLocationCoordinate2D) {
        addCoordinate(coordinate)
    }
    
    private func addCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let newCoordinate = IdentifiableCoordinate(coordinate: coordinate)
        self.selectedCoordinates = [newCoordinate] // This will allow only one pin at a time. If you want multiple pins, remove the `[ ]`.
    }
}


