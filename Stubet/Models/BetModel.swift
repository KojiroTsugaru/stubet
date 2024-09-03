//
//  BetModel.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import Foundation

struct Bet: Identifiable {
    let id: String
    let title: String
    let timeRemaining: String
    let location: String
    let distance: String
    let imageName: String
    
    // Initialize from Firebase data
    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? ""
        self.timeRemaining = data["timeRemaining"] as? String ?? ""
        self.location = data["location"] as? String ?? ""
        self.distance = data["distance"] as? String ?? ""
        self.imageName = data["imageName"] as? String ?? "defaultImage"
    }
}
