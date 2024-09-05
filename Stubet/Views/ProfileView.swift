//
//  ProfileView.swift
//  Stubet
//
//  Created by 百人力ニキ on 2024/09/05.


import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    init() {
        let mockUser = User(id: "1", data: ["displayName": "Phillip Stanton", "userName": "pstanton", "icon_url": "https://example.com/image.jpg"])
            // 他のモックフレンドを追加
        self.viewModel = ProfileViewModel(user: mockUser)
    }
    
    var body: some View {
        VStack {
            // Header
            Text("My profile")
                .font(.headline)
            
            // User Profile Info
            VStack {
                AsyncImage(url: URL(string: viewModel.user.iconUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                    } else {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                }
                
                Text(viewModel.user.displayName)
                    .font(.title)
                Text("ID #\(viewModel.user.id) • \(viewModel.user.userName)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            Spacer()
            
            // Display Friend Requests if available
            FriendRequestsView(friendRequests: viewModel.friendRequests)
            
            // Always display Friends if available
            FriendsView(friends: viewModel.user.friends)
        }
        .padding()
        .navigationBarTitle("Profile", displayMode: .inline)
        .onAppear {
            viewModel.fetchFriends()
        }
    }
}

struct FriendRequestsView: View {
    let friendRequests: [FriendRequest]
    
    var body: some View {
        if !friendRequests.isEmpty {
            VStack(alignment: .leading) {
                Text("\(friendRequests.count) follow request(s)")
                    .foregroundColor(.red)
                    .font(.headline)
                
                ForEach(friendRequests) { request in
                    HStack {
                        let senderIconUrl = "https://example.com/placeholder.jpg"
                        let senderDisplayName = "User \(request.senderId)"
                        AsyncImage(url: URL(string: senderIconUrl)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else if phase.error != nil {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            } else {
                                ProgressView()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        
                        Text(senderDisplayName)
                    }
                }
            }
        }
    }
}

struct FriendsView: View {
    let friends: [Friend]
    
    var body: some View {
        if !friends.isEmpty {
            VStack(alignment: .leading) {
                Text("\(friends.count) follows")
                    .font(.headline)
                
                ForEach(friends) { friend in
                    HStack {
                        AsyncImage(url: URL(string: friend.iconUrl)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else if phase.error != nil {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            } else {
                                ProgressView()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        
                        Text(friend.displayName)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        // モックの友達データ
        let mockFriends = [
            Friend(id: "2", data: ["displayName": "Phillip Stanton", "userName": "pstanton", "icon_url": "https://example.com/image.jpg"]),
            Friend(id: "3", data: ["displayName": "Randy Workman", "userName": "rworkman", "icon_url": "https://example.com/image.jpg"]),
            Friend(id: "4", data: ["displayName": "John Smith", "userName": "jsmith", "icon_url": "https://example.com/image.jpg"]),
            Friend(id: "5", data: ["displayName": "Omar Calzoni", "userName": "ocalzoni", "icon_url": "https://example.com/image.jpg"])
        ]
        
        // モックの友達リクエストデータ
        let mockRequests = [
            FriendRequest(id: "1", data: ["senderId": "6", "receiverId": "1", "status": "pending"]),
            FriendRequest(id: "2", data: ["senderId": "7", "receiverId": "1", "status": "pending"])
        ]
        
        // モックのユーザーデータ
        let mockUser = User(id: "1", data: ["displayName": "Tsugaru Kojiro", "userName": "kojikoji", "icon_url": "https://example.com/image.jpg"])
        
        // モックデータを使用してUserViewModelを作成
        let mockViewModel = ProfileViewModel(user: mockUser)
        mockViewModel.user.friends = mockFriends
        mockViewModel.friendRequests = mockRequests
        
        // ProfileViewにモックViewModelを渡す
        return ProfileView()
    }
}
