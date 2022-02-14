//
//  PruebasTarjeta.swift
//  VistasBasicasSwiftUI
//
//  Created by Jorge Agullo Martin on 11/2/22.
//

import SwiftUI
import CoreData

//Clase para compartir datos en entorno
class UserData: ObservableObject {
    @Published var nombre: String = ""
    @Published var apellidos: String = ""
    @Published var puestoTrabajo: String = ""
    @Published var telefono: String = ""
    @Published var email: String = ""
    @Published var direccion: String = ""
    @Published var direccion2: String = ""
    @Published var dataComplete: Bool = false
}

struct FormDataView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            
            ZStack {
                Image("aluminio")
                    .resizable()
                    .frame(width: .infinity, height: 250)
                Image("cardWhite")
                    .resizable()
                    .frame(width: 300, height: 220)
                    .padding(.top, 30)
            }
                
            Text("Crea tu tarjeta de visita")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.blue)
            
                
            Form {
                Text("Datos personales")
                    .font(.title2)
                    .italic()
                    .foregroundColor(Color.blue)
                
                TextField("Nombre", text: $userData.nombre)
                    .autocapitalization(.words)
                TextField("Apellido", text: $userData.apellidos)
                    .autocapitalization(.words)
                TextField("Puesto de trabajo", text: $userData.puestoTrabajo)
                    .autocapitalization(.words)
                Section{
                    Text("Datos de contacto")
                        .font(.title2)
                        .italic()
                        .foregroundColor(Color.blue)
                    TextField("Teléfono", text: $userData.telefono)
                        .keyboardType(.numberPad)
                    TextField("e-Mail", text: $userData.email)
                        .keyboardType(.emailAddress)
                    TextField("Dirección", text: $userData.direccion)
                        .autocapitalization(.words)
                    TextField("Dirección2", text: $userData.direccion2)
                        .autocapitalization(.words)
                }
            }.padding(0)
             .onAppear {
                UITableView.appearance().backgroundColor = .clear
             }
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

class EntryFields {
    var symbol: String = ""
    var data: String = ""
    
}


struct FormDataView_Previws: PreviewProvider {
    static var previews: some View {
        
        FormDataView()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(UserData())
    }
}
