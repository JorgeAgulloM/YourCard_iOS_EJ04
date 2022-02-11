//
//  YourCardApp.swift
//  YourCard
//
//  Created by Jorge Agullo Martin on 11/2/22.
//

import SwiftUI

@main
struct YourCardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
