//
//  HomeViewModel.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import Foundation
import Combine
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var newMissions: [Mission] = []
    @Published var ongoingMissions: [Mission] = []
    
    @Published var newBets: [Bet] = []
    @Published var ongoingBets: [Bet] = []
    
    @Published var selectedTab: Tab = .mission
    
    enum Tab {
        case mission
        case bet
    }
    
    private var db = Firestore.firestore()
    private let currentUserId: String  // Pass the current logged-in user's ID
    
    
    init(curretUserId: String = "1", newMissions: [Mission] = [], ongoingMissions: [Mission] = [],
         newBets: [Bet] = [], ongoingBets: [Bet] = []) {
        self.currentUserId = curretUserId
        if newMissions.isEmpty && ongoingMissions.isEmpty && newBets.isEmpty && ongoingBets.isEmpty {
            // Fetch from Firebase only if no dummy data is provided
            fetchBets()
        } else {
            // Use dummy data if provided
            self.newMissions = newMissions
            self.ongoingMissions = ongoingMissions
            self.newBets = newBets
            self.ongoingBets = ongoingBets
        }
    }
    
    func fetchBets() {
        db.collection("bets").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching bets: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            for doc in documents {
                let data = doc.data()
                let bet = Bet(id: doc.documentID, data: data)
                
                // if receiverId is matched with current user's id, treat it as Mission
                if bet.receiverId == self.currentUserId {
                    let mission = Mission(from: bet)
                    self.newMissions.append(mission)
                } else {
                    self.newBets.append(bet)
                }
            }
            
            
            // Adjust logic accordingly
            self.ongoingBets = self.newBets
            self.ongoingMissions = self.newMissions
        }
    }
}
