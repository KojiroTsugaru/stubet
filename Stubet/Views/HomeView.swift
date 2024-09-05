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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Tab Switching: ミッション and ペット buttons
            HStack {
                
                // Logout button
                Button(action: {
                    viewModel.logout()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                .padding(.leading)
                
                Spacer()
                Button(action: {
                    viewModel.selectedTab = .mission
                }) {
                    Text("ミッション")
                        .font(.system(size: 12))
                        .padding(10)
                        .background(viewModel.selectedTab == .mission ? Color.orange : Color.clear)
                        .foregroundColor(viewModel.selectedTab == .mission ? .white : .gray)
                        .cornerRadius(48)
                }
                Spacer()
                Button(action: {
                    viewModel.selectedTab = .bet
                }) {
                    Text("ベット")
                        .font(.system(size: 12))
                        .padding(10)
                        .background(viewModel.selectedTab == .bet ? Color.orange : Color.clear)
                        .foregroundColor(viewModel.selectedTab == .bet ? .white : .gray)
                        .cornerRadius(48)
                }
                Spacer()
            }
            .padding(.bottom)
            
            // Content depending on the selected tab
            ScrollView {
                if viewModel.selectedTab == .mission {
                    missionSection
                } else {
                    betSection
                }
            }
        }
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
                    NavigationLink(destination: MissionDetailsView(mission: mission)) {
                        MissionRowView(mission: mission, isNew: true)
                    }
                    .padding(.horizontal)
                }
            }
            
            if viewModel.ongoingMissions.count > 0 {
                Text("進行中のミッション")
                    .font(.headline)
                    .padding(.leading)
                
                ForEach(viewModel.ongoingMissions) { mission in
                    NavigationLink(destination: MissionDetailsView(mission: mission)) {
                        MissionRowView(mission: mission, isNew: false)
                    }
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
            if viewModel.rewardPendingBets.count > 0 {
                Text("報酬を受け取っていません！")
                    .font(.headline)
                    .padding(.leading)
                
                ForEach(viewModel.rewardPendingBets) { bet in
                    NavigationLink(destination: BetDetailsView(bet: bet)) {
                        BetRowView(bet: bet, isNew: true)
                    }
                    .padding(.horizontal)
                }
            }
            
            if viewModel.ongoingBets.count > 0 {
                Text("進行中のベット")
                    .font(.headline)
                    .padding(.leading)
                
                ForEach(viewModel.ongoingBets) { bet in
                    NavigationLink(destination: BetDetailsView(bet: bet)) {
                        BetRowView(bet: bet, isNew: false)
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("進行中ベットはありません")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: 250)
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
            rewardPendingBets: dummyBets,
            ongoingBets: dummyBets
        )
        
        return HomeView(viewModel: viewModel)
    }
}

#Preview {
    HomeView_Previews.previews
}
