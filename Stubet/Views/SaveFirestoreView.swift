//
//  SaveFirestoreView.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import SwiftUI
import FirebaseFirestore

struct SaveFirestoreView: View {
    @StateObject private var viewModel = SaveFirestoreViewModel()
    @State private var uploadResult: String = ""
    
    // Sample Bet data
    private var sampleBet = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Sample Bet",
            "description": "This is a sample bet description.",
            "deadline": Timestamp(date: Date().addingTimeInterval(60*60*24)), // 1日後
            "createdAt": Timestamp(date: Date()),
            "updatedAt": Timestamp(date: Date()),
            "senderId": "user123",
            "receiverId": "user456",
            "status": "pending",
            "location": [
                "name": "Sample Location",
                "address": "123 Sample St",
                "latitude": 37.7749,
                "longitude": -122.4194
            ]
        ]
    )

    // Sample Bet data with status "invitePending"
    private var sampleBetInvitePending = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Pending Bet",
            "description": "This bet is currently pending approval.",
            "deadline": Timestamp(date: Date().addingTimeInterval(60*60*48)), // 2日後
            "createdAt": Timestamp(date: Date()),
            "updatedAt": Timestamp(date: Date()),
            "senderId": "user789",
            "receiverId": "user012",
            "status": "invitePending",
            "location": [
                "name": "Pending Location",
                "address": "456 Pending Ave",
                "latitude": 34.0522,
                "longitude": -118.2437
            ]
        ]
    )

    // Sample Bet data with status "inviteRejected"
    private var sampleBetInviteRejected = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Rejected Bet",
            "description": "This bet has been rejected.",
            "deadline": Timestamp(date: Date().addingTimeInterval(60*60*72)), // 3日後
            "createdAt": Timestamp(date: Date()),
            "updatedAt": Timestamp(date: Date()),
            "senderId": "user345",
            "receiverId": "user678",
            "status": "inviteRejected",
            "location": [
                "name": "Rejected Location",
                "address": "789 Rejected Rd",
                "latitude": 40.7128,
                "longitude": -74.0060
            ]
        ]
    )

    // Sample Bet data with status "inviteExpired"
    private var sampleBetInviteExpired = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Expired Bet",
            "description": "This bet has expired without a response.",
            "deadline": Timestamp(date: Date().addingTimeInterval(-60*60*24)), // 1日前
            "createdAt": Timestamp(date: Date().addingTimeInterval(-60*60*48)), // 2日前
            "updatedAt": Timestamp(date: Date().addingTimeInterval(-60*60*24)), // 1日前
            "senderId": "user901",
            "receiverId": "user234",
            "status": "inviteExpired",
            "location": [
                "name": "Expired Location",
                "address": "101 Expired Blvd",
                "latitude": 51.5074,
                "longitude": -0.1278
            ]
        ]
    )

    // Sample Bet data with status "ongoing"
    private var sampleBetOngoing = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Ongoing Bet",
            "description": "This bet is currently ongoing.",
            "deadline": Timestamp(date: Date().addingTimeInterval(60*60*96)), // 4日後
            "createdAt": Timestamp(date: Date().addingTimeInterval(-60*60*24)), // 1日前
            "updatedAt": Timestamp(date: Date()),
            "senderId": "user567",
            "receiverId": "user890",
            "status": "ongoing",
            "location": [
                "name": "Ongoing Location",
                "address": "202 Ongoing St",
                "latitude": 48.8566,
                "longitude": 2.3522
            ]
        ]
    )

    // Sample Bet data with status "failed"
    private var sampleBetFailed = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Failed Bet",
            "description": "This bet has failed.",
            "deadline": Timestamp(date: Date().addingTimeInterval(-60*60*24)), // 1日前
            "createdAt": Timestamp(date: Date().addingTimeInterval(-60*60*48)), // 2日前
            "updatedAt": Timestamp(date: Date().addingTimeInterval(-60*60*24)), // 1日前
            "senderId": "user111",
            "receiverId": "user222",
            "status": "failed",
            "location": [
                "name": "Failed Location",
                "address": "303 Failed Ave",
                "latitude": 35.6895,
                "longitude": 139.6917
            ]
        ]
    )

    // Sample Bet data with status "rewardPending"
    private var sampleBetRewardPending = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Reward Pending Bet",
            "description": "This bet is successful, but the reward is pending.",
            "deadline": Timestamp(date: Date().addingTimeInterval(-60*60*24)), // 1日前
            "createdAt": Timestamp(date: Date().addingTimeInterval(-60*60*72)), // 3日前
            "updatedAt": Timestamp(date: Date().addingTimeInterval(-60*60*24)), // 1日前
            "senderId": "user333",
            "receiverId": "user444",
            "status": "rewardPending",
            "location": [
                "name": "Reward Pending Location",
                "address": "404 Reward Rd",
                "latitude": 55.7558,
                "longitude": 37.6173
            ]
        ]
    )

    // Sample Bet data with status "rewardReceived"
    private var sampleBetRewardReceived = Bet(
        id: UUID().uuidString,
        data: [
            "title": "Reward Received Bet",
            "description": "This bet is successful and the reward has been received.",
            "deadline": Timestamp(date: Date().addingTimeInterval(-60*60*48)), // 2日前
            "createdAt": Timestamp(date: Date().addingTimeInterval(-60*60*96)), // 4日前
            "updatedAt": Timestamp(date: Date().addingTimeInterval(-60*60*48)), // 2日前
            "senderId": "user555",
            "receiverId": "user666",
            "status": "rewardReceived",
            "location": [
                "name": "Reward Received Location",
                "address": "505 Reward Blvd",
                "latitude": 41.9028,
                "longitude": 12.4964
            ]
        ]
    )

    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.addBet(bet: sampleBet) { result in
                    switch result {
                    case .success:
                        uploadResult = "Bet uploaded successfully!"
                    case .failure(let error):
                        uploadResult = "Upload failed: \(error.localizedDescription)"
                    }
                }
            }) {
                Text("Upload Bet")
            }
            
            Text(uploadResult)
                .padding()
        }
        .padding()
    }
}
