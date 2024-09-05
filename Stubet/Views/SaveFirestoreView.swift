//
//  SaveFirestoreView.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import SwiftUI
import FirebaseFirestore

struct AddBetView: View {
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
