//
//  BetRowView.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI

struct BetRowView: View {
    var bet: Bet
    var isNew: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                // Mission Title
                Text(bet.title)
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
                    Text(bet.location.name)
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
                        gradient: Gradient(stops: [
                            .init(color: Color(red: 1.00, green: 0.50, blue: 0.29), location: 0.0),  // Darker orange
                            .init(color: Color(red: 1.00, green: 0.65, blue: 0.29), location: 1.0),  // Lighter orange
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
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
