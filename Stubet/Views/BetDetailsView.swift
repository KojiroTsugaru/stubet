//
//  BetDetailView.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import SwiftUI

struct BetDetailsView: View {
    @ObservedObject var viewModel: BetDetailsViewModel

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
                            
                            Text(viewModel.bet.title)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Text(viewModel.bet.description)
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
                            Text("9:30 A.M - \(viewModel.bet.deadline.dateValue(), formatter: dateFormatter)")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text("16時間後")
                                .foregroundColor(.orange)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "location")
                            Text(viewModel.bet.location.name)
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
