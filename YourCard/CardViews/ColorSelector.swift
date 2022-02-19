//
//  ColorSelector.swift
//  YourCard
//
//  Created by Jorge Agullo Martin on 14/2/22.
//

import SwiftUI
import CoreData

struct ColorSelector : View {
    
    //  Propiedades del objeto
    var id: Int = 3
    var sizeScreenWidth = UIScreen.main.bounds.width
    var sizeScreenHeigth = UIScreen.main.bounds.height
    @Binding var finalColor: Color
    @Binding var colorPresed: Int
    @State private var touch: Bool = false
    @Binding var cardSelect: Bool
    
    //  Array de colores predefinidos
    let colorPredefined: Array<Color> = [Color.gray, Color.red, Color.blue,  Color.green, Color.yellow]
    
    var body: some View {
        GeometryReader{ proxy in
            //  Montaje de las tarjetas de selección de color
            ZStack {
                Image("aluminio")
                    .resizable()
                    .opacity(0.6)
                    .frame(width: colorPresed == id ? 90 : 70, height: colorPresed == id ? 75 : 50, alignment: .center)
                    .background(colorPredefined[id])
                    .clipShape((RoundedRectangle(cornerRadius: 8.0, style: .continuous)))
                    .shadow(color: .black, radius: colorPresed == id ? 2 : 1, x: -0.5, y: -0.5)
                    
                HStack{
                    Section{
                        Text("J A")
                            .bold()
                            .frame(width: colorPresed == id ? 30 : 18, height: colorPresed == id ? 30 : 18, alignment: .center)
                        
                    }
                    .background(Color.white)
                    .clipShape(Circle())
                    .opacity(0.6)
                        
                    VStack{
                        Text("Jorge Agulló)")
                        Text("Estudiante iOS")
                    }
                   
                }
                .font(.custom("cambria", size: colorPresed == id ? 6 : 5))
                .foregroundColor(Color.black)
                
            }
            .padding(.horizontal, -20)
            .rotation3DEffect(.degrees(30), axis: (x: 0, y: 1, z: -1))
            .onTapGesture {
                colorPresed = id
                finalColor = colorPredefined[id]
                cardSelect.toggle()
            }.animation(.interpolatingSpring(stiffness: 50, damping: 6), value: self.cardSelect)
        }
    }
}
