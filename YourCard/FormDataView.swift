//
//  PruebasTarjeta.swift
//  VistasBasicasSwiftUI
//
//  Created by Jorge Agullo Martin on 11/2/22.
//

import SwiftUI
import CoreData

struct FormDataView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State var nombre: String = ""
    @State var apellidos: String = ""
    @State var puestoTrabajo: String = ""
    @State var telefono: String = ""
    @State var email: String = ""
    @State var direccion: String = ""
    @State var direccion2: String = ""
    
    var body: some View {
        TabView{
                VStack {
                    Image(systemName: "creditcard")
                        .resizable()
                        .frame(width: 120, height: 90)
                        .foregroundColor(Color.blue)
                    Text("Crea tu tarjeta de visita")
                        .font(.largeTitle)
                        .bold()
                        .italic()
                        .foregroundColor(Color.blue)
                    Form {
                        Text("Introduce tus datos")
                            .font(.title)
                            .italic()
                            .foregroundColor(Color.blue)
                        TextField("Nombre", text: $nombre)
                            .autocapitalization(.words)
                        TextField("Apellido", text: $apellidos)
                            .autocapitalization(.words)
                        TextField("Puesto de trabajo", text: $puestoTrabajo)
                            .autocapitalization(.words)
                        Section{
                            TextField("Teléfono", text: $telefono)
                                .keyboardType(.numberPad)
                            TextField("e-Mail", text: $email)
                                .keyboardType(.emailAddress)
                            TextField("Dirección", text: $direccion)
                                .autocapitalization(.words)
                            TextField("Dirección2", text: $direccion2)
                                .autocapitalization(.words)
                        }
                        
                    }
                }
                .background(Color.yellow)
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

struct FormDataView_Previws: PreviewProvider {
    static var previews: some View {
        FormDataView()
.previewInterfaceOrientation(.portrait)
    }
}
