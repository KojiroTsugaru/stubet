//
//  makeBetViewModel.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/03.
//

import Foundation
import Combine
import FirebaseFirestore

class CreateBetViewModel: ObservableObject {
    @Published var selectedUser: Follow?
    @Published var title: String = ""
    @Published var betContent: String = ""
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    private let db = Firestore.firestore()
    
    init() {
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        // ここでFirebaseから実際のユーザーデータを取得する処理を実装します
        self.currentUser = User(id: "1", last_name: "木嶋", first_name: "太郎", user_id: 1, user_name: "木嶋太郎", friends: [
            Follow(user_id: 2, success: 5, failure: 2),
            Follow(user_id: 3, success: 3, failure: 1)
        ], friend_request: [])
    }
    
    func createBet(completion: @escaping (Bool) -> Void) {
        guard let selectedUser = selectedUser else {
            completion(false)
            return
        }
        
        let newBet = [
            "title": title,
            "content": betContent,
            "targetUserId": selectedUser.user_id,
            "createdAt": Timestamp()
        ] as [String : Any]
        
        db.collection("bets").addDocument(data: newBet) { error in
            if let error = error {
                print("Error adding bet: \(error)")
                completion(false)
            } else {
                print("Bet successfully created")
                completion(true)
            }
        }
    }
}
