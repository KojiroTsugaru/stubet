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
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var missionSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("新しいミッションが届いています")
                .font(.headline)
                .padding(.leading)
            
            ForEach(viewModel.newMissions) { mission in
                MissionRowView(mission: mission, isNew: true)
                    .padding(.horizontal)
            }
            
            Text("進行中のミッション")
                .font(.headline)
                .padding(.leading)
            
            ForEach(viewModel.ongoingMissions) { mission in
                MissionRowView(mission: mission, isNew: false)
                    .padding(.horizontal)
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


#Preview {
    HomeView()
}
