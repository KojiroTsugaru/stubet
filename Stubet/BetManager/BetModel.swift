//
//  BetModel.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import Foundation
import FirebaseFirestore

struct Bet: Identifiable {
    let id: String           // betId (document ID or UUID)
    let title: String        // Title of the bet
    let description: String  // Description of the bet
    let deadline: Timestamp  // Deadline for the bet (Firestore Timestamp)
    let createdAt: Timestamp // Timestamp when the bet was created
    let updatedAt: Timestamp // Timestamp when the bet was last updated
    let senderId: String     // User ID of the person who created the bet
    let receiverId: String   // User ID of the person who receives the bet
    let location: Location   // Location object (nested)
    
    var status: String       // invitePending, inviteRejected, inviteExpired, ongoing, rewardReceived, rewardPending, failed

    // Initialize from Firebase document data
    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.deadline = data["deadline"] as? Timestamp ?? Timestamp(date: Date())
        self.createdAt = data["createdAt"] as? Timestamp ?? Timestamp(date: Date())
        self.updatedAt = data["updatedAt"] as? Timestamp ?? Timestamp(date: Date())
        self.senderId = data["senderId"] as? String ?? ""
        self.receiverId = data["receiverId"] as? String ?? ""
        self.status = data["status"] as? String ?? "pending"
        
        if let locationData = data["location"] as? [String: Any] {
            self.location = Location(data: locationData)
        } else {
            // Default location if none provided
            self.location = Location(data: [
                "name": "",
                "address": "",
                "latitude": 0.0,
                "longitude": 0.0
            ])
        }
    }
}
