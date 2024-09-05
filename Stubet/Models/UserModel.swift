//
//  UserModel.swift
//  Stubet
//
//  Created by KJ on 9/4/24.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable {
    let id: String              // userId (UUID or unique string)
    let userName: String         // unique string in roman letters
    let iconUrl: String          // URL of the user's icon
    let displayName: String      // Full display name of the user
    let createdAt: Timestamp     // Creation timestamp
    let updatedAt: Timestamp     // Last updated timestamp
    var friends: [Friend] = []   // List of friends (Subcollection)

    // Initialize from Firebase document data
    init(id: String, data: [String: Any]) {
        self.id = id
        self.userName = data["userName"] as? String ?? ""
        self.iconUrl = data["icon_url"] as? String ?? ""
        self.displayName = data["displayName"] as? String ?? ""
        self.createdAt = data["createdAt"] as? Timestamp ?? Timestamp(date: Date())
        self.updatedAt = data["updatedAt"] as? Timestamp ?? Timestamp(date: Date())
        
        // Initialize friends as an empty array, to be populated later
        self.friends = []
    }
}