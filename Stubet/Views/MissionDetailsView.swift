//
//  MissionDetailsView.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import SwiftUI

struct MissionDetailsView: View {
    let mission: Mission
    var body: some View {
        VStack {
            Text(mission.title)
        }.padding()
            .navigationBarHidden(false)  // Hide navigation bar
    }
}

//#Preview {
//    MissionDetailsView()
//}
