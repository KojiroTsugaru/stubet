//
//  BetDetailsView.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import SwiftUI
import FirebaseFirestore

struct BetDetailsView: View {
    
    let bet: Bet
    
    init() {
        self.bet = Bet(id: "example_id", data: [
            "title": "明日の一限遅刻したらラーメン奢りで！",
            "description": "もし明日の一限に遅刻したら、ラーメンを奢ることになります。頑張って早起きしましょう！",
            "deadline": Timestamp(date: dateFormatter.date(from: "09/02/2024 9:30 AM") ?? Date()),
            "createdAt": Timestamp(date: Date()),
            "updatedAt": Timestamp(date: Date()),
            "senderId": "sender_id",
            "receiverId": "receiver_id",
            "status": "invitePending",
            //        "status": "inviteRejected",
            "location": [
                "name": "千葉大学 1号館",
                "address": "",
                "latitude": 0.0,
                "longitude": 0.0
            ]
        ])
    }
    
    init (bet: Bet) {
        self.bet = bet
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Bet Content Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("ベット内容")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        Text("進行中")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("木嶋陸")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text(bet.title)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Text(bet.description)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding()
                
                // Location & Time Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("場所＆時間")
                        .font(.headline)
                        .padding(.bottom, 5)
                    EventView()
                }
                
                // Invite Response Buttons
                if bet.status == "invitePending" {
                    //                if true {
                    VStack(spacing: 10) {
                        Button(action: {
                            // 申請を受ける処理
                        }) {
                            Text("受ける")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            // 申請を拒否する処理
                        }) {
                            Text("拒否する")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("詳細")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
