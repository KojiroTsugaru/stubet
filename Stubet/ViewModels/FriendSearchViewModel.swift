//
//  FriendSearchViewModel.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import Combine

class FriendSearchViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        // Fetch users from Firebase or any data source
        // For now, we will use mock data
        let mockData: [User] = [
            User(id: "1", data: ["userName": "Demi Hickman", "icon_url": "", "displayName": "Customer"]),
            User(id: "2", data: ["userName": "Jacob Jones", "icon_url": "", "displayName": "Technician"]),
            User(id: "3", data: ["userName": "Lightning Mc Queen", "icon_url": "", "displayName": "Technician"]),
            User(id: "4", data: ["userName": "Elle Macdonald", "icon_url": "", "displayName": "Admin"]),
            User(id: "5", data: ["userName": "Gethings Done", "icon_url": "", "displayName": "BOT"])
        ]
        self.users = mockData
    }
}
