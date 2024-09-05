//
//  UserViewModel.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/05.
//

import Foundation
import Combine
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var friendRequests: [FriendRequest] = []
    @Published var user: User
    private var db = Firestore.firestore()
    private let currentUserId: String
    
    

    init(user: User) {
        self.user = user
        self.currentUserId = user.id // Set the user ID from the passed user instance
        fetchFriendRequests()
        fetchFriends()
    }

    // Fetch friend requests from Firestore
    func fetchFriendRequests() {
        db.collection("users").document(currentUserId).collection("friendRequests").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching friend requests: \(error)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            // Map each document to FriendRequest model
            self?.friendRequests = documents.compactMap { FriendRequest(id: $0.documentID, data: $0.data()) }
        }
    }

    // Fetch friends from Firestore
    func fetchFriends() {
        db.collection("users").document(currentUserId).collection("friends").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching friends: \(error)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            // Map each document to Friend model
            self?.user.friends = documents.compactMap { Friend(id: $0.documentID, data: $0.data()) }
        }
    }
}
