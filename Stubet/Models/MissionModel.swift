//
//  MissionModel.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import Foundation
import FirebaseFirestore

struct Mission {
    let id: String
    let title: String
    let description: String
    let deadline: Timestamp
    let location: Location

    init(from bet: Bet) {
        self.id = bet.id
        self.title = bet.title
        self.description = bet.description
        self.deadline = bet.deadline
        self.location = bet.location
    }
}
