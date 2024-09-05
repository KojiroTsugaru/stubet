//
//  HomeView.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    // Use the locationManager as an EnvironmentObject
    @EnvironmentObject var locationManager: UserLocationManager
    
    @State private var showingModal = false
    
    // Track the nearest mission location to the user gets close to
    @State private var nearestMission: Mission?
    
    init() {
        self.viewModel = HomeViewModel()
    }
    
    var body: some View {
        VStack {
            // Tab Switching: ミッション and ペット buttons
            HStack {
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
        .onAppear {
            // Start updating the location when the view appears
            locationManager.startUpdatingLocation()
        }
        .onDisappear {
            // Optionally stop location updates when the view disappears
            locationManager.stopUpdatingLocation()
        }
        .onChange(of: locationManager.isCloseToAnyTarget) { isClose in
            // Show the modal when the user is close to any target location
            if isClose {
                if let targetLocation = locationManager.nearestLocation {
                    // Find the mission corresponding to the location
                    nearestMission = viewModel.ongoingMissions.first(where: { $0.location.name == targetLocation.name })
                    showingModal = true
                }
            }
        }
        .sheet(isPresented: $showingModal) {
            // The modal content
            VStack {
                if let target = locationManager.nearestLocation {
                    Text("You are close to \(target.name)!")
                        .font(.title)
                        .padding()
                    Text("Address: \(target.address)")
                    Text("Latitude: \(target.latitude)")
                    Text("Longitude: \(target.longitude)")
                } else {
                    Text("You are close to a target location!")
                        .font(.title)
                        .padding()
                }
                Button("Dismiss and Update Status") {
                    if let missionToUpdate = nearestMission {
                        // Change the status of the mission to "rewardPending"
                        viewModel.updateMissionStatus(mission: missionToUpdate, newStatus: "rewardPending")
                        locationManager.removeTargetLocation(missionToUpdate.location.name)
                    }

                    nearestMission = nil
                    showingModal = false
                }
            }
        }
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
        
        return HomeView()
    }
}

#Preview {
    HomeView_Previews.previews
}
