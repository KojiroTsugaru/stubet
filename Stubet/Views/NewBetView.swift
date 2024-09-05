//
//  NewBetView.swift
//  Stubet
//
//  Created by KJ on 9/4/24.
//

import SwiftUI

struct NewBetView: View {
    var body: some View {
        VStack {
            Text("New Bet View")
        } .navigationBarHidden(false) // Hide the navigation bar
            .toolbar(.hidden, for: .tabBar)  // Hide the tab bar
    }
}

#Preview {
    NewBetView()
}
