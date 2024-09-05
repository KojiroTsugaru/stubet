//
//  ContentView.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        // Set tab bar appearance
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            //profile view
            NavigationView{
                HomeView()
                    .navigationTitle("ホーム")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(
                        trailing: NavigationLink(destination: NewBetView()) {
                            Image(systemName: "plus")
                                .font(.title2)
                        })
            }
            .tabItem {
                Image(systemName: "house")
                Text("ホーム")
            }
            
            // Profile view
            NavigationView{
                HomeView()
                    .navigationTitle("プロフィール")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("プロフィール")
            }
            
        }
        
        .accentColor(Color.orange)
    }
}


#Preview {
    ContentView()
}
