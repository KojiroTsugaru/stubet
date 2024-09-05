//
//  BetDetailViewModel.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import Foundation
import FirebaseFirestore

class BetDetailsViewModel: ObservableObject {
    @Published var bet: Bet

    init(bet: Bet) {
        self.bet = bet
    }
}
