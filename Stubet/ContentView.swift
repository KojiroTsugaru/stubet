import SwiftUI
import Firebase
import FirebaseAuth

//class AuthViewModel: ObservableObject {
//    @Published var currentUser = Auth.auth().currentUser
//
//    init() {
//        Auth.auth().addStateDidChangeListener { _, user in
//            self.currentUser = user
//
//            // currentUser が nil でない場合のみ UserProvider に ID をセット
//            if let user = user {
//                    UserProvider.shared.refreshCurrentUser()
//                }
//            }
//        }
//    }

struct ContentView: View {
    //    @StateObject private var authViewModel = AuthViewModel()
    
    init() {
        // Set tab bar appearance
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}
