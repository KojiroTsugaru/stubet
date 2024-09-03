//
//  MissionRowView.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI

struct MissionRowView: View {
    var mission: Mission
    var isNew: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(mission.title)
                    .font(.headline)
                    .foregroundColor(isNew ? Color.white : Color.primary)
                Text(mission.timeRemaining)
                    .font(.subheadline)
                    .foregroundColor(isNew ? Color.white.opacity(0.7) : Color.secondary)
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(mission.location)
                    Text(mission.distance)
                }
                .font(.caption)
                .foregroundColor(isNew ? Color.white.opacity(0.7) : Color.secondary)
            }
            Spacer()
            Image(mission.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
        .padding()
        .background(isNew ? Color.orange : Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}


#Preview {
    MissionRowView()
}
