//
//  NewBetSharedViewModel.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import Foundation
import Combine
import FirebaseFirestore

class SharedBetViewModel: ObservableObject {
    @Published var selectedFriend: Friend?
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date()
    @Published var time: Date = Date()
    @Published var friends: [Friend] = []

    private var db = Firestore.firestore()
    private let currentUserId: String

    init(currentUserId: String) {
        self.currentUserId = currentUserId
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
}
