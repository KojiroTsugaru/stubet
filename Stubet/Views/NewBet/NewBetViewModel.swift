//
//  CreateBetViewModel.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/04.
//

import Foundation
import Combine
import FirebaseFirestore

class NewBetViewModel: ObservableObject {
    @Published var selectedFriend: Friend?
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var friends: [Friend] = []

    private var db = Firestore.firestore()
    private let currentUserId: String

    init() {
        self.currentUserId = "1"
        fetchFriends()
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

    func createBet(completion: @escaping (Bool) -> Void) {
        guard let selectedFriend = selectedFriend else {
            completion(false)
            return
        }

        let newBet = [
            "title": title,
            "description": description,
            "deadline": Timestamp(date: Date().addingTimeInterval(24 * 60 * 60)), // 24 hours from now
            "createdAt": Timestamp(date: Date()),
            "updatedAt": Timestamp(date: Date()),
            "senderId": currentUserId,
            "receiverId": selectedFriend.id,
            "status": "pending",
            "location": [
                "name": "",
                "address": "",
                "latitude": 0.0,
                "longitude": 0.0
            ]
        ] as [String : Any]

        db.collection("bets").addDocument(data: newBet) { error in
            if let error = error {
                print("Error adding bet: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
