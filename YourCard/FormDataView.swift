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
    
    //Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    
    var body: some View {
         VStack {
             presentationView()
             FormView()
         }.edgesIgnoringSafeArea(.all)
        ._scrollable()
    }
}

struct presentationView: View {
    let sizeScreenWidth = UIScreen.main.bounds.width
    
    //Cuerpo de la imagen de cabecera
    var body: some View {
        ZStack {
            Image("aluminio")
                .resizable()
                .frame(width: sizeScreenWidth, height: 200)
            VStack {
            Image("cardWhite")
            .resizable()
            .frame(width: 200, height: 120)
            .padding(.top, 25)
            Text("Crea tu tarjeta de visita")
                .font(.largeTitle)
                .italic()
                .foregroundColor(Color.blue)
                .padding(.top, -20)
            }
        }
    }
}

struct FormView: View {
    
    //  Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    
    //  Formulario para la inserción de datos, solo se valida el email y el teléfono
    var body: some View {

            Form {
                Text("Datos personales")
                    .font(.title2)
                    .italic()
                    .foregroundColor(Color.blue)
                
                TextField("\(Image(systemName: "person.crop.circle")) Nombre", text: $userData.name)
                    .autocapitalization(.words)
                
                TextField("\(Image(systemName: "person.crop.circle")) Apellido", text: $userData.surname)
                    .autocapitalization(.words)
                
                TextField("\(Image(systemName: "briefcase")) Puesto de trabajo", text: $userData.job)
                    .autocapitalization(.words)
                
                Section{
                    Text("Datos de contacto")
                        .font(.title2)
                        .italic()
                        .foregroundColor(Color.blue)
                    
                    TextField("\(Image(systemName: "phone.circle")) Teléfono", text: $userData.phoneNumber)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.numberPad)
                        .background((userData.phoneNumber.count > 0 && !userData.textFieldValidatorPhone(userData.phoneNumber)) ? LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                    
                    TextField("\(Image(systemName: "envelope.circle")) e-Mail", text: $userData.email)
                        .textInputAutocapitalization(.never) //Evita que la primera letra sea mayúscula
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .background((userData.email.count > 0 && !userData.textFieldValidatorEmail(userData.email)) ? LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                    
                    TextField("\(Image(systemName: "house")) Dirección", text: $userData.address)
                        .autocapitalization(.words)
                    
                    TextField("\(Image(systemName: "house")) Dirección2", text: $userData.address2)
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
