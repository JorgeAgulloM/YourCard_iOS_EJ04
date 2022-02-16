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
    
    //Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    var finalColor: Color = Color.blue
    var foreColorSelect: Color = Color.black
    var logoColorSelect: Color = Color.white
    var aluminio: Bool = true
    @Binding var cardReversed: Bool

    var body: some View {
        ZStack {
            VStack{
                if !cardReversed {
                    HStack{
                        Section{
                            Text("\(String(userData.nombre == "" ? "?" : userData.nombre.prefix(1)))")
                                .font(.largeTitle)
                                .bold()
                                .frame(width: 80, height: 80, alignment: .center)
                        }
                        .background(logoColorSelect).opacity(aluminio ? 0.6 : 1)
                        .clipShape(Circle())
                            
                        VStack{
                            Text("\(userData.nombre == "" ? "Nombre" : userData.nombre) \(userData.apellidos == "" ? "Apellido" : userData.apellidos)")
                            Text("\(userData.puestoTrabajo == "" ? "Puesto de trabajo" : userData.puestoTrabajo)")
                        }
                        
                    }
                    
                } else {
                    Section{
                        Text("\(Image(systemName: "phone.circle")) \(userData.telefono == "" ? "000000000" : userData.telefono)")
                        Text("\(Image(systemName: "envelope.circle")) \(userData.email == "" ? "email@dominio.com" : userData.email)")
                        Text("\(Image(systemName: "house")) \(userData.direccion == "" ? "Dirección" : userData.direccion)")
                        if !userData.direccion2.elementsEqual("") {
                            Text("\(Image(systemName: "house")) \(userData.direccion2)")
                        }
                    }
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    
                  
                }
            }.background(aluminio ? Image("aluminio") : nil)
                .opacity(aluminio ? 0.6 : 1)
                .font(.title2)
                .foregroundColor(foreColorSelect)
            
            
        }.frame(width: 280, height: 190, alignment: .center)
        .cornerRadius(25)
        .background(finalColor)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .rotation3DEffect(.degrees(cardReversed ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .shadow(color: .black, radius: 5, x: 3, y: 3)
        .shadow(color: finalColor, radius: 5, x: -3, y: -3)
        .onTapGesture {
            self.cardReversed.toggle()
        }.animation(.easeInOut, value: self.cardReversed)
    }
}

//struct CardView_Previws: PreviewProvider {
//    static var previews: some View {
//        CardView()
//            .previewInterfaceOrientation(.portrait)
//            .environmentObject(UserData())
//    }
//}
