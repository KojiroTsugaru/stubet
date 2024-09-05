import Foundation
import Combine
import FirebaseFirestore
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allMissions: [Mission] = []
    @Published var allBets: [Bet] = []
    @Published var newMissions: [Mission] = []
    @Published var ongoingMissions: [Mission] = []
    
    @Published var rewardPendingBets: [Bet] = []
    @Published var ongoingBets: [Bet] = []
    
    @Published var selectedTab: Tab = .mission
    
    enum Tab {
        case mission
        case bet
    }
    
    private var db = Firestore.firestore()
    private let currentUserId: String  // Pass the current logged-in user's ID
    
    // Use the locationManager as an EnvironmentObject
    @EnvironmentObject var locationManager: UserLocationManager
    
    
    init(newMissions: [Mission] = [], ongoingMissions: [Mission] = [],
         rewardPendingBets: [Bet] = [], ongoingBets: [Bet] = []) {
        // UserProviderからcurrentUserIdを取得
        self.currentUserId = UserProvider.shared.getCurrentUserId() ?? "1"
        if newMissions.isEmpty && ongoingMissions.isEmpty && rewardPendingBets.isEmpty && ongoingBets.isEmpty {
            // Fetch from Firebase only if no dummy data is provided
            fetchBets()
        } else {
            // Use dummy data if provided
            self.newMissions = newMissions
            self.ongoingMissions = ongoingMissions
            self.rewardPendingBets = rewardPendingBets
            self.ongoingBets = ongoingBets
            
            // Add the ongoingMissions to the UserLocationManager
            addOngoingMissionsToLocationManager()
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
                
                // If receiverId is matched with current user's id, treat it as Mission
                if bet.receiverId == self.currentUserId {
                    let mission = Mission(from: bet)
                    self.allMissions.append(mission)
                } else {
                    self.allBets.append(bet)
                }
            }
            
            // Assign bets and missions based on status
            // For Bets
            for bet in self.allBets {
                if bet.status == "ongoing" {
                    self.ongoingBets.append(bet)
                } else if bet.status == "rewardPending" {
                    self.rewardPendingBets.append(bet)
                }
            }
            
            // For Missions
            for mission in self.allMissions {
                if mission.status == "ongoing" {
                    self.ongoingMissions.append(mission)
                } else if mission.status == "invitePending" {
                    self.newMissions.append(mission)
                }
            }
            
            // Add the ongoingMissions to the UserLocationManager
            self.addOngoingMissionsToLocationManager()
        }
    }
    
    // Add locations from ongoingMissions to the UserLocationManager's targetLocations
    private func addOngoingMissionsToLocationManager() {
        for mission in ongoingMissions {
            
            let location = mission.location
            
            // Add each mission's location to the UserLocationManager
            locationManager.addTargetLocation(location)
        }
    }
    
    func updateMissionStatus(mission: Mission, newStatus: String) {
        // Find the mission in the ongoingMissions array and update its status
        if let index = ongoingMissions.firstIndex(where: { $0.id == mission.id }) {
            ongoingMissions[index].status = newStatus
            
            // You can also update the Firestore document if necessary
            db.collection("bets").document(mission.id).updateData([
                "status": newStatus
            ]) { error in
                if let error = error {
                    print("Error updating mission status: \(error)")
                } else {
                    print("Mission status updated successfully")
                }
            }
        }
    }
}
