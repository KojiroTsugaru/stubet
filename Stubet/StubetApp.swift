//
//  StubetApp.swift
//  Stubet
//
//  Created by KJ on 9/3/24.
//

import SwiftUI

@main
struct StubetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
