//
//  HomeView.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            // Tab Switching: ミッション and ペット buttons
            HStack {
                Button(action: {
                    viewModel.selectedTab = .mission
                }) {
                    Text("ミッション")
                        .padding()
                        .background(viewModel.selectedTab == .mission ? Color.orange : Color.clear)
                        .foregroundColor(viewModel.selectedTab == .mission ? .white : .gray)
                        .cornerRadius(20)
                }
                Spacer()
                Button(action: {
                    viewModel.selectedTab = .bet
                }) {
                    Text("ベット")
                        .padding()
                        .background(viewModel.selectedTab == .bet ? Color.orange : Color.clear)
                        .foregroundColor(viewModel.selectedTab == .bet ? .white : .gray)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal)
            
            // Content depending on the selected tab
            ScrollView {
                if viewModel.selectedTab == .mission {
                    missionSection
                } else {
                    betSection
                }
            }
        }
        .navigationTitle("ホーム")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: NavigationLink(destination: NewBetView()) {
                Image(systemName: "plus")
                    .font(.title2)
            })
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var missionSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if viewModel.newMissions.count > 0 {
                Text("新しいミッションが届いています")
                    .font(.headline)
                    .padding(.leading)
                
                ForEach(viewModel.newMissions) { mission in
                    MissionRowView(mission: mission, isNew: true)
                        .padding(.horizontal)
                }
            }
            
            if viewModel.ongoingMissions.count > 0 {
                Text("進行中のミッション")
                    .font(.headline)
                    .padding(.leading)
                
                ForEach(viewModel.ongoingMissions) { mission in
                    MissionRowView(mission: mission, isNew: false)
                        .padding(.horizontal)
                }
            } else {
                Text("進行中のミッションはありません")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: 250)
            }
        }
    }
    
    // MARK: - Bet Section
    var betSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("新しいベットが届いています")
                .font(.headline)
                .padding(.leading)
            
            ForEach(viewModel.newBets) { bet in
                BetRowView(bet: bet, isNew: true)
                    .padding(.horizontal)
            }
            
            Text("進行中のベット")
                .font(.headline)
                .padding(.leading)
            
            ForEach(viewModel.ongoingBets) { bet in
                BetRowView(bet: bet, isNew: false)
                    .padding(.horizontal)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Dummy location data
        let dummyLocation = Location(data: [
            "name": "Location 1",
            "address": "123 Street, City",
            "latitude": 35.6586,
            "longitude": 139.7454
        ])
        
        // Dummy bets
        let dummyBets = [
            Bet(id: "1", data: [
                "title": "Dummy Bet 1",
                "description": "Description for bet 1",
                "deadline": Timestamp(date: Date().addingTimeInterval(3600)),
                "createdAt": Timestamp(date: Date()),
                "updatedAt": Timestamp(date: Date()),
                "senderId": "user1",
                "receiverId": "user2",
                "status": "pending",
                "location": dummyLocation
            ]),
            Bet(id: "2", data: [
                "title": "Dummy Bet 2",
                "description": "Description for bet 2",
                "deadline": Timestamp(date: Date().addingTimeInterval(7200)),
                "createdAt": Timestamp(date: Date()),
                "updatedAt": Timestamp(date: Date()),
                "senderId": "user2",
                "receiverId": "user3",
                "status": "ongoing",
                "location": dummyLocation
            ])
        ]
        
        // Dummy missions (wrapping the bets)
        let dummyMissions = dummyBets.map { bet -> Mission in
            return Mission(from: bet)
        }
        
        // Initialize HomeViewModel with dummy data
        let viewModel = HomeViewModel(
            newMissions: dummyMissions,
            ongoingMissions: dummyMissions,
            newBets: dummyBets,
            ongoingBets: dummyBets
        )
        
        return HomeView(viewModel: viewModel)
    }
}

#Preview {
    HomeView_Previews.previews
}
