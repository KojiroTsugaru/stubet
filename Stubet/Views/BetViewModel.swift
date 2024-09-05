//
//  BetViewModel.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import Foundation
import FirebaseFirestore

class BetViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    func addBet(bet: Bet, completion: @escaping (Result<Void, Error>) -> Void) {
        let betData: [String: Any] = [
            "title": bet.title,
            "description": bet.description,
            "deadline": bet.deadline,
            "createdAt": bet.createdAt,
            "updatedAt": bet.updatedAt,
            "senderId": bet.senderId,
            "receiverId": bet.receiverId,
            "status": bet.status,
            "location": [
                "name": bet.location.name,
                "address": bet.location.address,
                "latitude": bet.location.latitude,
                "longitude": bet.location.longitude
            ]
        ]
        
        db.collection("bets").document(bet.id).setData(betData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
