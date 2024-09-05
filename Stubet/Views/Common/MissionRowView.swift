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
            VStack(alignment: .leading, spacing: 8) {
                // Mission Title
                Text(mission.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(isNew ? Color.white : Color.primary)
                
                // Time Remaining
                Text("16 時間後")
                    .font(.subheadline)
                    .foregroundColor(isNew ? Color.white : Color.secondary)
                
                // Location and Distance
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(mission.location.name)
                    Text("4.5 km")
                    
                    Spacer()
                    
                    // Profile Image
                    Image("DummyProfileImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
                .font(.caption)
                .foregroundColor(isNew ? Color.white : Color.secondary)
            }
        }
        .padding()
        .background(isNew ?
                    AnyView(LinearGradient(
                        stops: [
                            .init(color: Color(red: 1.00, green: 0.75, blue: 0.29), location: 0.00),
                            .init(color: Color(red: 1.00, green: 0.62, blue: 0.29), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 1, y: 0),
                        endPoint: UnitPoint(x: 0, y: 1)
                    ))
                    : AnyView(Color(UIColor.systemBackground)))
        .cornerRadius(10)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isNew ? Color.orange.opacity(0) : Color.gray.opacity(0.2), lineWidth: 1)
        )
        
    }
}
