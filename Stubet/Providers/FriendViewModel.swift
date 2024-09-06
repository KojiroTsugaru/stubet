//
//  FriendViewModel.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/06.
//

import Foundation
import FirebaseFirestore

class FriendViewModel: ObservableObject {
    @Published var friends: [Friend] = []
    @Published var friendRequests: [FriendRequest] = []
    @Published var currentUser: Friend?
    
    private var db = Firestore.firestore()
    
    func fetchCurrentUser(userId: String) {
        db.collection("users").document(userId).getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                self?.currentUser = Friend(id: document.documentID, data: document.data() ?? [:])
            }
        }
    }
    
    func fetchFriends(userId: String) {
        db.collection("friends").whereField("userId", isEqualTo: userId)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No friends found")
                    return
                }
                
                self?.friends = documents.compactMap { Friend(id: $0.documentID, data: $0.data()) }
            }
    }
    
    func fetchFriendRequests(userId: String) {
        db.collection("friendRequests").whereField("receiverId", isEqualTo: userId)
            .whereField("status", isEqualTo: "pending")
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No friend requests found")
                    return
                }
                
                self?.friendRequests = documents.compactMap { FriendRequest(id: $0.documentID, data: $0.data()) }
            }
    }
}
