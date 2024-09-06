//
//  ProfileView.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/06.
//

import SwiftUI
import FirebaseCore

struct ProfileView: View {
    @StateObject var viewModel: MockFriendViewModel
    let userId: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("My Profile")
                .font(.headline)
//                .padding(.top)
            
            if let currentUser = viewModel.currentUser {
                VStack(spacing: 8) {
                    AsyncImage(url: URL(string: currentUser.iconUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Circle().foregroundColor(.gray)
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    Text(currentUser.displayName)
                        .font(.title)
                    
                    Text("ID #\(currentUser.id) • HVAC Technician")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            if !viewModel.friendRequests.isEmpty {
                Text("\(viewModel.friendRequests.count) friend request\(viewModel.friendRequests.count > 1 ? "s" : "")")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
                
                ForEach(viewModel.friendRequests) { request in
                    if let sender = viewModel.friends.first(where: { $0.id == request.senderId }) {
                        FriendRequestView(friendRequest: request, sender: sender)
                    }
                }
            }
            
            if !viewModel.friends.isEmpty {
                Text("\(viewModel.friends.count) friend\(viewModel.friends.count > 1 ? "s" : "")")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
                
                FriendView(viewModel: viewModel)
            }
        }
    }
}

struct FriendRequestView: View {
    let friendRequest: FriendRequest
    let sender: Friend
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: sender.iconUrl)) { image in
                image.resizable()
            } placeholder: {
                Circle().foregroundColor(.gray)
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            Text(sender.displayName)
                .font(.body)
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct FriendView: View {
    @ObservedObject var viewModel: FriendViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.friends.indices, id: \.self) { index in
                let friend = viewModel.friends[index]
                HStack {
                    AsyncImage(url: URL(string: friend.iconUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Circle().foregroundColor(.gray)
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    
                    Text(friend.displayName)
                        .font(.body)
                    
                    Spacer()
                    
                    Text(String(format: "%02d", index + 1))
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }
}

// サンプルデータと他のコードは変更なし

// サンプルデータの定義
extension Friend {
    static let sampleFriends = [
        Friend(id: "1", data: ["userName": "john_doe", "displayName": "Jorstar Doe", "icon_url": "https://scontent-nrt1-2.cdninstagram.com/v/t51.29350-15/417187053_909491007381823_8890119924504756456_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE0NDAuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=scontent-nrt1-2.cdninstagram.com&_nc_cat=107&_nc_ohc=dZfiQOFv8YsQ7kNvgFTV60Z&_nc_gid=ae38360df9fa493c812b67a47b7893a7&edm=AEhyXUkBAAAA&ccb=7-5&ig_cache_key=MzI3NTcyNzIxMzQyNDk3Mjg5Ng%3D%3D.3-ccb7-5&oh=00_AYDFyV9K97q8VYHwV9lcfdBAmNO6T-MhnsdUrAOnwdkFtQ&oe=66DF6F9A&_nc_sid=8f1549"]),
        Friend(id: "2", data: ["userName": "jane_smith", "displayName": "Jane Smith", "icon_url": "https://scontent-nrt1-2.cdninstagram.com/v/t51.29350-15/417187053_909491007381823_8890119924504756456_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE0NDAuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=scontent-nrt1-2.cdninstagram.com&_nc_cat=107&_nc_ohc=dZfiQOFv8YsQ7kNvgFTV60Z&_nc_gid=ae38360df9fa493c812b67a47b7893a7&edm=AEhyXUkBAAAA&ccb=7-5&ig_cache_key=MzI3NTcyNzIxMzQyNDk3Mjg5Ng%3D%3D.3-ccb7-5&oh=00_AYDFyV9K97q8VYHwV9lcfdBAmNO6T-MhnsdUrAOnwdkFtQ&oe=66DF6F9A&_nc_sid=8f1549"]),
        Friend(id: "3", data: ["userName": "bob_johnson", "displayName": "Bob Johnson", "icon_url": "https://scontent-nrt1-2.cdninstagram.com/v/t51.29350-15/417187053_909491007381823_8890119924504756456_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE0NDAuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=scontent-nrt1-2.cdninstagram.com&_nc_cat=107&_nc_ohc=dZfiQOFv8YsQ7kNvgFTV60Z&_nc_gid=ae38360df9fa493c812b67a47b7893a7&edm=AEhyXUkBAAAA&ccb=7-5&ig_cache_key=MzI3NTcyNzIxMzQyNDk3Mjg5Ng%3D%3D.3-ccb7-5&oh=00_AYDFyV9K97q8VYHwV9lcfdBAmNO6T-MhnsdUrAOnwdkFtQ&oe=66DF6F9A&_nc_sid=8f1549"])
    ]
    
    static let sampleCurrentUser = Friend(id: "current", data: ["userName": "steven_less", "displayName": "Tsugaru Kojiro", "icon_url": "https://scontent-nrt1-2.cdninstagram.com/v/t51.29350-15/417187053_909491007381823_8890119924504756456_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE0NDAuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=scontent-nrt1-2.cdninstagram.com&_nc_cat=107&_nc_ohc=dZfiQOFv8YsQ7kNvgFTV60Z&_nc_gid=ae38360df9fa493c812b67a47b7893a7&edm=AEhyXUkBAAAA&ccb=7-5&ig_cache_key=MzI3NTcyNzIxMzQyNDk3Mjg5Ng%3D%3D.3-ccb7-5&oh=00_AYDFyV9K97q8VYHwV9lcfdBAmNO6T-MhnsdUrAOnwdkFtQ&oe=66DF6F9A&_nc_sid=8f1549"])
}

extension FriendRequest {
    static let sampleFriendRequest = FriendRequest(id: "req1", data: [
        "senderId": "1",
        "receiverId": "current",
        "status": "pending",
        "createdAt": Timestamp(date: Date()),
        "updatedAt": Timestamp(date: Date())
    ])
}

// モックのFriendViewModel
class MockFriendViewModel: FriendViewModel {
    override init() {
        super.init()
        self.currentUser = Friend.sampleCurrentUser
        self.friends = Friend.sampleFriends
        self.friendRequests = [FriendRequest.sampleFriendRequest]
    }
}

// プレビュー用
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: MockFriendViewModel(), userId: "current")
    }
}

struct FriendRequestView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestView(friendRequest: FriendRequest.sampleFriendRequest, sender: Friend.sampleFriends[0])
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView(viewModel: MockFriendViewModel())
    }
}
