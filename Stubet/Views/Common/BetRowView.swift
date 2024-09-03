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
            VStack(alignment: .leading) {
                Text(bet.title)
                    .font(.headline)
                    .foregroundColor(isNew ? Color.white : Color.primary)
                Text(bet.timeRemaining)
                    .font(.subheadline)
                    .foregroundColor(isNew ? Color.white.opacity(0.7) : Color.secondary)
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(bet.location)
                    Text(bet.distance)
                }
                .font(.caption)
                .foregroundColor(isNew ? Color.white.opacity(0.7) : Color.secondary)
            }
            Spacer()
            Image(bet.imageName)
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
    BetRowView()
}
