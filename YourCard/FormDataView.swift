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
        if UIDevice.current.orientation.isLandscape {
             HStack {
                 presentationView()
                 FormView()
             }.edgesIgnoringSafeArea(.all)
             
         } else {
             VStack {
                 
                 presentationView()
                 FormView()
             }.edgesIgnoringSafeArea(.all)
             
         }
        
    }
}

struct presentationView: View {
    let sizeScreenWidth = UIScreen.main.bounds.width
    //var sizeScreenHeigth = UIScreen.main.bounds.height
    var body: some View {
        VStack {
        ZStack {
            Image("aluminio")
                .resizable()
                .frame(width: sizeScreenWidth, height: 300)
            VStack {
            Image("cardWhite")
                .resizable()
                .frame(width: 300, height: 220)
                .padding(.top, 20)
                Text("Crea tu tarjeta de visita")
                    .font(.largeTitle)
                    .italic()
                    .foregroundColor(Color.blue)
                    .padding(.top, -20)
                }
            }
        }
    }
}

struct FormView: View {
    
    //Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        Form {
            Text("Datos personales")
                .font(.title2)
                .italic()
                .foregroundColor(Color.blue)
            
            TextField("\(Image(systemName: "person.crop.circle")) Nombre", text: $userData.nombre)
                .autocapitalization(.words)
            TextField("\(Image(systemName: "person.crop.circle")) Apellido", text: $userData.apellidos)
                .autocapitalization(.words)
            TextField("\(Image(systemName: "briefcase")) Puesto de trabajo", text: $userData.puestoTrabajo)
                .autocapitalization(.words)
            Section{
                Text("Datos de contacto")
                    .font(.title2)
                    .italic()
                    .foregroundColor(Color.blue)
                TextField("\(Image(systemName: "phone.circle")) Teléfono", text: $userData.telefono)
                    .keyboardType(.numberPad)
                TextField("\(Image(systemName: "envelope.circle")) e-Mail", text: $userData.email)
                    .keyboardType(.emailAddress)
                TextField("\(Image(systemName: "house")) Dirección", text: $userData.direccion)
                    .autocapitalization(.words)
                TextField("\(Image(systemName: "house")) Dirección2", text: $userData.direccion2)
                    .autocapitalization(.words)
            }
        }.padding(.top, -30)
         .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
    }
}


struct FormDataView_Previws: PreviewProvider {
    static var previews: some View {
        
        FormDataView()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(UserData())
    }
}
