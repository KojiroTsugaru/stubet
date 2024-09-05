import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var currentUser = Auth.auth().currentUser

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.currentUser = user

            // currentUser が nil でない場合のみ UserProvider に ID をセット
            if let user = user {
                    UserProvider.shared.refreshCurrentUser()
                }
            }
        }
    }

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()

    init() {
        // Set tab bar appearance
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        NavigationView {
            TabView {
                // Home view (ログイン状態によって表示を切り替える)
                Group {
                    if authViewModel.currentUser != nil {
                        HomeView()
                            .navigationTitle("ホーム")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(
                                trailing: NavigationLink(destination: NewBetView()) {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                }
                            )
                    } else {
                        LoginView()
                    }
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("ホーム")
                }

                // Profile view (ここは実際のプロフィール画面に置き換える)
//                ProfileView()
//                    .navigationTitle("プロフィール")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .tabItem {
//                        Image(systemName: "person.fill")
//                        Text("プロフィール")
//                    }
            }
            .accentColor(Color.orange)
        }
    }
}
