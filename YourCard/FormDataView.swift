//
//  PruebasTarjeta.swift
//  VistasBasicasSwiftUI
//
//  Created by Jorge Agullo Martin on 11/2/22.
//

import SwiftUI
import CoreData

//  Clase observable para compartir datos en entorno
class UserData: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var job: String = ""
    @Published var phoneNumber: Int?
    @Published var email: String = ""
    @Published var address: String = ""
    @Published var address2: String = ""
    @Published var dataComplete: Bool = false
    
}

//  Función para validar el email
func textFieldValidatorEmail(_ string: String) -> Bool {

    //  Patrón de comparación para formar un email correcto.
    let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: string)
    
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
        //  Para dividir los objetos de la pantalla en dos para poder visualizarla en landscape.
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
    
    //Cuerpo de la imagen de cabecera
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
                TextField("\(Image(systemName: "phone.circle")) Teléfono", value: $userData.phoneNumber, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                TextField("\(Image(systemName: "envelope.circle")) e-Mail", text: $userData.email)
                    .textInputAutocapitalization(.never) //Evita que la primera letra sea mayúscula
                    .keyboardType(.emailAddress)
                    .background((userData.email.count > 0 && !textFieldValidatorEmail(userData.email)) ? LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
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
