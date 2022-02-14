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

    //Variable instanciada de la clase Userdata para compartir datos en el entorno de la app.
    var userData = UserData()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(userData) //Se añade la variable como objeto de entorno
        }
    }
}
