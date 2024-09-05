//
//  MissionModel.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import Foundation
import FirebaseFirestore

struct Mission: Identifiable {
    let id: String
    let title: String
    let description: String
    let deadline: Timestamp
    let location: Location
    var status: String // invitePending, inviteRejected, inviteExpired, ongoing, rewardReceived, rewardPending, failed

    init(from bet: Bet) {
        self.id = bet.id
        self.title = bet.title
        self.description = bet.description
        self.deadline = bet.deadline
        self.location = bet.location
        self.status = bet.status
    }
}
