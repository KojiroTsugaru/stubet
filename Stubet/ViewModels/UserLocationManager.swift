//
//  LocationManager.swift
//  Stubet
//
//  Created by KJ on 9/6/24.
//

import SwiftUI
import CoreLocation

class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var location: CLLocation? // Current user location
    @Published var isCloseToAnyTarget: Bool = false // Flag to check proximity to any target
    @Published var nearestLocation: Location? // Store the nearest target location
    
    private var targetLocations: [Location] = [] // List of target locations with name, address, lat, long
    let proximityThreshold: CLLocationDistance = 100 // Distance in meters to trigger the modal

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request permission
        locationManager.requestWhenInUseAuthorization()
    }

    // Method to start updating the location
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    // Method to stop updating the location
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    // Delegate method to update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        location = latestLocation
        
        // Check proximity to all target locations
        checkProximity(to: targetLocations, from: latestLocation)
    }

    // Method to check if user is within proximity of any target location
    private func checkProximity(to targets: [Location], from userLocation: CLLocation) {
        for target in targets {
            let distance = userLocation.distance(from: target.clLocation)
            print("Distance to \(target.name): \(distance) meters")
            
            // If user is within the threshold for any location, update the flag and nearest target
            if distance <= proximityThreshold {
                isCloseToAnyTarget = true
                nearestLocation = target
                return
            }
        }
        
        // If no target is within range, reset the flag and nearest target
        isCloseToAnyTarget = false
        nearestLocation = nil
    }

    // Methods to dynamically add, remove, or clear target locations
    func addTargetLocation(_ location: Location) {
        targetLocations.append(location)
    }

    func removeTargetLocation(_ name: String) {
        targetLocations.removeAll { $0.name == name }
    }

    func clearAllTargetLocations() {
        targetLocations.removeAll()
    }

    // Error handling
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}

struct LocationTestView: View {
    @EnvironmentObject var locationManager: UserLocationManager
    @State private var showingModal = false

    var body: some View {
        VStack (spacing: 2) {
            if let location = locationManager.location {
                Text("Latitude: \(location.coordinate.latitude)")
                Text("Longitude: \(location.coordinate.longitude)")
            } else {
                Text("Fetching location...")
            }
            
            // Buttons to add and remove target locations for testing purposes
            Button("Add San Francisco Target") {
                let sanFrancisco = Location(data: [
                    "name": "San Francisco",
                    "address": "San Francisco, CA",
                    "latitude": 37.7749,
                    "longitude": -122.4194
                ])
                locationManager.addTargetLocation(sanFrancisco)
            }
            
            Button("Add 秋葉原") {
                let akiba = Location(data: [
                    "name": "秋葉原",
                    "address": "San Francisco, CA",
                    "latitude": 35.697870,
                    "longitude": 139.774694
                ])
                locationManager.addTargetLocation(akiba)
            }
            
            
            Button("Add Los Angeles Target") {
                let losAngeles = Location(data: [
                    "name": "Los Angeles",
                    "address": "Los Angeles, CA",
                    "latitude": 34.0522,
                    "longitude": -118.2437
                ])
                locationManager.addTargetLocation(losAngeles)
            }
            
            Button("Remove San Francisco Target") {
                locationManager.removeTargetLocation("San Francisco")
            }
            
            Button("Clear All Target Locations") {
                locationManager.clearAllTargetLocations()
            }
        }
        .padding()
        .onAppear {
            // Start updating the location when the view appears
            locationManager.startUpdatingLocation()
        }
        .onDisappear {
            // Optionally stop location updates when the view disappears
            locationManager.stopUpdatingLocation()
        }
        .onChange(of: locationManager.isCloseToAnyTarget) { isClose in
            // Show the modal when the user is close to any target location
            if isClose {
                showingModal = true
            }
            
        }
        .sheet(isPresented: $showingModal) {
            // The modal content
            VStack {
                if let target = locationManager.nearestLocation {
                    Text("You are close to \(target.name)!")
                        .font(.title)
                        .padding()
                    Text("Address: \(target.address)")
                    Text("Latitude: \(target.latitude)")
                    Text("Longitude: \(target.longitude)")
                } else {
                    Text("You are close to a target location!")
                        .font(.title)
                        .padding()
                }
                Button("Dismiss") {
                    showingModal = false
                }
            }
        }
    }
}


// Preview with Mock Data
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with mock location data
        ContentViewPreviewWrapper()
    }
}

// Wrapper for injecting mock location data
struct ContentViewPreviewWrapper: View {
    @StateObject private var mockLocationManager = UserLocationManager()

    init() {
        
    }

    var body: some View {
        LocationTestView()
            .environmentObject(mockLocationManager)
    }
}
