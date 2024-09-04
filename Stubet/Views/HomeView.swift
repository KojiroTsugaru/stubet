//
//  HomeView.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
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
                        Text("ペット")
                            .padding()
                            .background(viewModel.selectedTab == .bet ? Color.orange : Color.clear)
                            .foregroundColor(viewModel.selectedTab == .bet ? .white : .gray)
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
                
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
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: NavigationLink(destination: NewBetView()) {
                    Image(systemName: "plus")
                        .font(.title2)
                })
        }.accentColor(Color.orange)
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
                Text("進行中のミッションはありません").frame(alignment: .center)
            }
        }
    }
    
    var betSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("報酬が支払われていません！")
                .font(.headline)
                .padding(.leading)
            
            ForEach(viewModel.newBets) { bet in
                BetRowView(bet: bet, isNew: true)
                    .padding(.horizontal)
            }
            
            Text("進行中のペット")
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
        let dummyMissions = [
            Mission(id: "1", data: [
                "title": "Dummy Mission 1",
                "timeRemaining": "2 hours",
                "location": "Location 1",
                "distance": "1 km",
                "imageName": "profileImage"
            ]),
            Mission(id: "2", data: [
                "title": "Dummy Mission 2",
                "timeRemaining": "4 hours",
                "location": "Location 2",
                "distance": "3 km",
                "imageName": "profileImage"
            ])
        ]
        
        let dummyBets = [
            Bet(id: "1", data: [
                "title": "Dummy Bet 1",
                "timeRemaining": "5 hours",
                "location": "Bet Location 1",
                "distance": "2 km",
                "imageName": "profileImage"
            ]),
            Bet(id: "2", data: [
                "title": "Dummy Bet 2",
                "timeRemaining": "1 day",
                "location": "Bet Location 2",
                "distance": "5 km",
                "imageName": "profileImage"
            ])
        ]
        
        let viewModel = HomeViewModel(newMissions: dummyMissions, ongoingMissions: dummyMissions, newBets: dummyBets, ongoingBets: dummyBets)
        
        return HomeView(viewModel: viewModel)
    }
}

#Preview {
    HomeView_Previews.previews
}
