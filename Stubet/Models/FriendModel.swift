//
//  FriendModel.swift
//  Stubet
//
//  Created by KJ on 9/4/24.
//

import Foundation

struct Friend: Identifiable , Hashable {
    let id: String
    let userName: String
    let displayName: String
    let iconUrl: String

    // Initialize from Firebase document data
    init(id: String, data: [String: Any]) {
        self.id = id
        self.userName = data["userName"] as? String ?? ""
        self.displayName = data["displayName"] as? String ?? ""
        self.iconUrl = data["icon_url"] as? String ?? ""
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        // MARK: - Equatable

        static func == (lhs: Friend, rhs: Friend) -> Bool {
            return lhs.id == rhs.id
        }
    }

