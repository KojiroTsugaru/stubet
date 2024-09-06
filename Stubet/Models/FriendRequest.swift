//
//  FriendRequestModel.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/05.
//

import Foundation
import FirebaseFirestore

struct FriendRequest: Identifiable {
    let id: String              // requestId (UUID or unique string)
    let senderId: String        // ID of the user who sent the request
    let receiverId: String      // ID of the user who received the request
    let status: String          // Status of the request (accepted, pending, rejected)
    let createdAt: Timestamp    // Creation timestamp
    let updatedAt: Timestamp    // Last updated timestamp

    // Initialize from Firebase document data
    init(id: String, data: [String: Any]) {
        self.id = id
        self.senderId = data["senderId"] as? String ?? ""
        self.receiverId = data["receiverId"] as? String ?? ""
        self.status = data["status"] as? String ?? "pending"
        self.createdAt = data["createdAt"] as? Timestamp ?? Timestamp(date: Date())
        self.updatedAt = data["updatedAt"] as? Timestamp ?? Timestamp(date: Date())
    }
}
