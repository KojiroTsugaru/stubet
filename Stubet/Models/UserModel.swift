import Foundation
import FirebaseFirestore

struct User: Identifiable {
    let id: String              // userId (UUID or unique string)
    let userName: String        // Unique string in roman letters
    var displayName: String     // Full display name of the user
    var iconUrl: String         // URL of the user's icon
    let email: String           // Email address of the user
    let createdAt: Timestamp    // Creation timestamp
    var updatedAt: Timestamp    // Last updated timestamp
    var friends: [Friend] = []  // List of friends (Subcollection)

    // Initialize from Firebase document data
    init(id: String, data: [String: Any]) {
        self.id = id
        self.userName = data["userName"] as? String ?? ""
        self.displayName = data["displayName"] as? String ?? "" // 修正点: displayNameの初期化
        self.iconUrl = data["icon_url"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.createdAt = data["createdAt"] as? Timestamp ?? Timestamp(date: Date())
        self.updatedAt = data["updatedAt"] as? Timestamp ?? Timestamp(date: Date())
        
        // Initialize friends as an empty array, to be populated later
        self.friends = [] // 必要に応じてフレンドリストを初期化
    }
}
