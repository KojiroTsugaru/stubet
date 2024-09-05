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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Bet Content Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("ベット内容")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        Text("進行中")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("木嶋陸")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text(mission.title)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Text(mission.description)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding()
                
                // Location & Time Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("場所＆時間")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "clock")
                            Text("9:30 A.M - \(mission.deadline.dateValue(), formatter: dateFormatter)")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text("16時間後")
                                .foregroundColor(.orange)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "location")
                            Text(mission.location.name)
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text("4.5 km")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("詳細")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
