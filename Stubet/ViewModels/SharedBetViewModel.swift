//
//  NewBetSharedViewModel.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import Foundation
import Combine
import FirebaseFirestore
import MapKit

class SharedBetViewModel: ObservableObject {
    @Published var selectedFriend: Friend?
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date()
    @Published var time: Date = Date()
    @Published var friends: [Friend] = []
    
    
    // For map
    @Published var searchText: String = ""
    @Published var selectedCoordinates: [IdentifiableCoordinate] = []
    @Published var region: MKCoordinateRegion

    private var db = Firestore.firestore()
    private let currentUserId: String

    init(currentUserId: String = "1") {
        self.currentUserId = currentUserId
        self.region = locationManager.region
        
        fetchFriends()
        bindLocationUpdates()
    }

    func fetchFriends() {
        db.collection("users").document(currentUserId).collection("friends").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching friends: \(error)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            self?.friends = documents.compactMap { Friend(id: $0.documentID, data: $0.data()) }
        }
    }
    
    private var locationManager = LocationManager()
    
    private func bindLocationUpdates() {
        locationManager.$region.assign(to: &$region)
    }
    
    func searchForLocation(searchText: String) {
        self.searchText = searchText
        locationManager.searchLocation(address: self.searchText) { coordinate in
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
