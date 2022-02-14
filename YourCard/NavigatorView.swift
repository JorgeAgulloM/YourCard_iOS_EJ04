//
//  NavigatorView.swift
//  YourCard
//
//  Created by Jorge Agullo Martin on 13/2/22.
//

import SwiftUI
import CoreData

struct NavigatorView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        TabView{
            FormDataView()
                .tabItem {
                    Image(systemName: "pencil.and.ellipsis.rectangle")
                    Text("Datos")
                }
            if  !userData.nombre.isEmpty && !userData.apellidos.isEmpty &&
                !userData.puestoTrabajo.isEmpty && !userData.telefono.isEmpty &&
                !userData.email.isEmpty {
                CardEditorView()
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("Tarjeta")
                    }
            }
            
        }.onAppear() {
            UITabBar.appearance().unselectedItemTintColor = .gray
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

struct NavigatorView_Previws: PreviewProvider {
    static var previews: some View {
        NavigatorView()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(UserData())
    }
}
