import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {

    init() {
        // Set tab bar appearance
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        TabView {
            // Home tab with NavigationView
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("ホーム")
            }
            
            // Profile tab with NavigationView (Uncomment when needed)
//            NavigationView {
//                ProfileView(userId: "12345")
//                    .navigationTitle("プロフィール")
//                    .navigationBarTitleDisplayMode(.inline)
//            }
//            .tabItem {
//                Image(systemName: "person.fill")
//                Text("プロフィール")
//            }
        }.accentColor(Color.orange)
    }
}
