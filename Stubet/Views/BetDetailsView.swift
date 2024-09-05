//
//  BetDetailsView.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import SwiftUI

struct BetDetailsView: View {
    let bet: Bet
    
    var body: some View {
        VStack {
            Text(bet.title)
        }
        .padding()
        .navigationBarHidden(false)  // Hide navigation bar
        .toolbar(.hidden, for: .tabBar)  // Hide tab bar
        
    }
}

//#Preview {
//    BetDetailsView()
//}
