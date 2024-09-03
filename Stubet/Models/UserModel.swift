//
//  UserModel.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/03.
//

// UserModel.swift
import Foundation

struct User: Identifiable, Codable {
    var id: String
    var last_name: String
    var first_name: String
    var user_id: Int
    var user_name: String
    var friends: [Follow]
    var friend_request: [Int]
}

struct Follow: Codable, Identifiable, Hashable {
    var id: Int { user_id }
    var user_id: Int
    var success: Int
    var failure: Int
    
    // Hashable プロトコルの要件を満たすために、hash(into:) メソッドを実装
    func hash(into hasher: inout Hasher) {
        hasher.combine(user_id)
    }
    
    // Equatable プロトコルの要件を満たすために、== 演算子を実装
    static func == (lhs: Follow, rhs: Follow) -> Bool {
        return lhs.user_id == rhs.user_id
    }
}
