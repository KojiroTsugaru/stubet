//
//  FriendSearchView.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import SwiftUI

struct FriendSearchView: View {
    @ObservedObject var viewModel = FriendSearchViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                HStack {
                    // Placeholder for user icon
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
            .navigationTitle("Profile")
        }
    }
}
