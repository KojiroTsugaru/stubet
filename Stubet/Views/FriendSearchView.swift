//
//  FriendSearchView.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import SwiftUI

struct FriendSearchView: View {
    @ObservedObject var viewModel = FriendSearchViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                List(viewModel.users.filter {
                    searchText.isEmpty ? true : $0.userName.localizedCaseInsensitiveContains(searchText)
                }) { user in
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text(user.userName)
                                .font(.headline)
                            Text(user.displayName)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Button(action: {
                            // Action for the button
                        }) {
                            Image(systemName: "person.crop.circle.badge.plus")
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search part name", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
