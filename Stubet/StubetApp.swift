//
//  StubetApp.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


@main
struct StubetApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //           ContentView()
            //               .environment(\.managedObjectContext, persistenceController.container.viewContext)
            // SignupView()
            // LoginView()
            LocationTestView()
                .environmentObject(UserLocationManager()) // Inject real location manager in the live app
        }
    }
}
