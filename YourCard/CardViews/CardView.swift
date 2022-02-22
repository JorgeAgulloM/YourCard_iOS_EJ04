//
//  CardView.swift
//  YourCard
//
//  Created by Jorge Agullo Martin on 14/2/22.
//

import SwiftUI
import CoreData

struct CardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    
    //  Propiedades del objeto
    var finalColor: Color = Color.blue
    var foreColorSelect: Color = Color.black
    var logoColorSelect: Color = Color.white
    var aluminum: Bool = true
    @Binding var cardReversed: Bool

    var body: some View {
        ZStack {
            VStack{
                // Control sobre la horientación de la tarjeta
                if !cardReversed {
                    HStack{
                        Section{
                            Text("\(String(userData.name == "" ? "?" : userData.name.prefix(1)))")
                                .font(.largeTitle)
                                .bold()
                                .frame(width: 80, height: 80, alignment: .center)
                        
                        }
                        .background(logoColorSelect).opacity(aluminum ? 0.6 : 1)
                        .clipShape(Circle())
                            
                        // Añade los texto a la tarjeta en el frente
                        VStack{
                            Text("\(userData.name == "" ? "Nombre" : userData.name) \(userData.surname == "" ? "Apellido" : userData.surname)")
                            Text("\(userData.job == "" ? "Puesto de trabajo" : userData.job)")
                        
                        }
                        
                    }
                    
                } else {
                    // Añade los texto a la tarjeta en la trasera
                    Section{
                        Text("\(Image(systemName: "phone.circle")) \((userData.phoneNumber == "" ? "000000000" : userData.phoneNumber))")
                        Text("\(Image(systemName: "envelope.circle")) \(userData.email == "" ? "email@dominio.com" : userData.email)")
                        Text("\(Image(systemName: "house")) \(userData.address == "" ? "Dirección" : userData.address)")
                        if !userData.address2.elementsEqual("") {
                            Text("\(Image(systemName: "house")) \(userData.address2)")
                        }
                    }.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    
                }
                
            }.background(aluminum ? Image("aluminio") : nil)
                .opacity(aluminum ? 0.6 : 1)
                .font(.title2)
                .foregroundColor(foreColorSelect)
            
            
        }.frame(width: 290, height: 200, alignment: .center)
        .cornerRadius(25)
        .background(finalColor)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .rotation3DEffect(.degrees(cardReversed ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .shadow(color: .black, radius: 5, x: 3, y: 3)
        .shadow(color: finalColor, radius: 5, x: -3, y: -3)
        .onTapGesture {
            self.cardReversed.toggle()
        }.animation(.interpolatingSpring(stiffness: 40, damping: 6), value: self.cardReversed)
    }
}
