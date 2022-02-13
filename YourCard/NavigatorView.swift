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
    
    var body: some View {
        TabView{
            FormDataView()
                .tabItem {
                    Image(systemName: "pencil.and.ellipsis.rectangle")
                    Text("Datos")
                }
            CardEditorView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Tarjeta")
                }
        }
    }
}

struct NavigatorView_Previws: PreviewProvider {
    static var previews: some View {
        NavigatorView().previewInterfaceOrientation(.portrait)
    }
}
