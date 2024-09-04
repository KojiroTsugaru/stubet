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
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("ホーム")
                }
            
            HomeView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("プロフィール")
                }
        }.accentColor(Color.orange)
    }
}


#Preview {
    ContentView()
}
