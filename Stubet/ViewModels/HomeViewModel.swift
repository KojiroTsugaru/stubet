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
    
    init() {
        fetchMissions()
        fetchBets()
    }
    
    func fetchMissions() {
        db.collection("missions").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching missions: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.newMissions = documents.map { doc in
                let data = doc.data()
                return Mission(id: doc.documentID, data: data)
            }
            
            self.ongoingMissions = self.newMissions // Just for example, adjust logic accordingly
        }
    }
    
    func fetchBets() {
        db.collection("bets").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching bets: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.newBets = documents.map { doc in
                let data = doc.data()
                return Bet(id: doc.documentID, data: data)
            }
            
            self.ongoingBets = self.newBets // Just for example, adjust logic accordingly
        }
    }
}
