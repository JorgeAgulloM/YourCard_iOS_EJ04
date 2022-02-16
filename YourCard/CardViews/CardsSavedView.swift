//
//  CardsSavedView.swift
//  YourCard
//
//  Created by Jorge Agullo Martin on 15/2/22.
//

import SwiftUI
import CoreData

struct CardsSavedView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        Text("Hoila")
    }
}
