//
//  CardView.swift
//  VistasBasicasSwiftUI
//
//  Created by Jorge Agullo Martin on 11/2/22.
//

import SwiftUI
import CoreData

struct CardEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @EnvironmentObject var userData: UserData
    
    var sizeScreenWidth = UIScreen.main.bounds.width
    var sizeScreenHeigth = UIScreen.main.bounds.height
    @State var arrayRGB: Array<Float> = [0.0, 0.0, 0.0]
    @State var personalColor: Bool = false
    @State var scaleCircles: Double = 0.6
    let colorPredefined: Array<Color> = [Color.gray, Color.yellow, Color.red,  Color.green, Color.blue, Color.orange]
    @State var colorPresed: Int = 0
    @State var cardReversed: Bool = false
    
    var body: some View {
        ZStack {
            Image("fondoAzul2")
                .resizable()
                .scaleEffect(1)
            
            VStack {
                Text("Selecciona un color")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 60)
                    .foregroundColor(Color.white)
                
                VStack {
//                    Text("Elige el color de tu tarjeta")
//                        .padding()
//                        .font(.title)
                    Toggle(isOn: $personalColor) {
                        Text("Personalizar?")
                            .font(.title2)
                    }.padding(.horizontal, 90)
                        .tint(Color.green)
                    
                    if personalColor {
                        VStack {
                            Slider(value: $arrayRGB[0])
                                .padding(.horizontal)
                                .accentColor(Color.red)
                            Slider(value: $arrayRGB[1])
                                .padding(.horizontal)
                                .accentColor(Color.green)
                            Slider(value: $arrayRGB[2])
                                .padding(.horizontal)
                                .accentColor(Color.blue)
                        }.padding(24)
                        
                    } else {
                        HStack{
                            ForEach(colorPredefined, id:\.self) { colorP in
                                ColorSelector(id: colorPredefined.firstIndex(of: colorP)!,
                                              colorCircle: colorP,
                                              colorPresed: $colorPresed)
                            }
                        }.padding(5)
                        
                    }
                }
                .foregroundColor(Color.white)
                .frame(width: (CGFloat(sizeScreenWidth) * 0.9), height: (CGFloat(sizeScreenHeigth) * 0.22))
                .cornerRadius(25)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .accessibilityHidden(personalColor)
                
                
                CardView(sizeScreenWidth: Float(sizeScreenWidth),
                         widthMultiplier: 0.9,
                         sizeScreenHeigth: Float(sizeScreenHeigth),
                         heigthMultiplier: 0.3,
                         colorPredefined: colorPredefined[colorPresed],
                         arrayRGB: arrayRGB,
                         personalColor: personalColor,
                         cardReversed: $cardReversed)
                
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ColorSelector : View {
    var id: Int
    var colorCircle: Color = Color.yellow
    @Binding var colorPresed: Int
    
    var body: some View {
        Capsule()
        .scale(0.6)
        .foregroundColor(colorCircle)
        .shadow(color: .white, radius: colorPresed == id ? 2 : 10)
        .onTapGesture {
            colorPresed = id
        }
//        ZStack{
//
//            Image("aluminio")
//                .opacity(0.6)
//
//        }
//        .frame(width: 40, height: 90)
//        .cornerRadius(25)
//        .background(colorCircle)
//        .clipShape(Capsule())
//        .shadow(color: .black, radius: 2, x: 1, y: 1)
//        .onTapGesture {
//            colorPresed = id
//        }
         
    }
    
}



struct CardView : View {
    //Variable de datos de entorno
    @EnvironmentObject var userData: UserData
    let sizeScreenWidth: Float
    let widthMultiplier: Float
    let sizeScreenHeigth: Float
    let heigthMultiplier: Float
    var colorPredefined: Color
    var arrayRGB: Array<Float> = [0.0, 0.0, 0.0]
    var personalColor: Bool
    @Binding var cardReversed: Bool

    var body: some View {
        
        VStack{
            ZStack {
                VStack{
                    if !cardReversed {
                        HStack{
                            Section{
                                Text("JA")
                                    .font(.largeTitle)
                                    .bold()
                                    .frame(width: 100, height: 100)
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                                
                            VStack{
                                Text("\(userData.nombre) \(userData.apellidos)")
                                Text("\(userData.puestoTrabajo)")
                            }
                            .font(.title)
                            .foregroundColor(Color.black)
                        }
                        
                    } else {
                        Section{
                            Text("\(userData.telefono)")
                            Text("\(userData.email)")
                            Text("\(userData.direccion)")
                            if !userData.direccion2.elementsEqual("") {
                                Text("\(userData.direccion2)")
                            }
                        }.font(.title)
                    }
                }
                
                Image("aluminio")
                    .opacity(0.6)
                    
            }
        }
        .frame(width: (CGFloat(sizeScreenWidth) * CGFloat(widthMultiplier)),
               height: (CGFloat(sizeScreenHeigth) * CGFloat(heigthMultiplier)))
        .cornerRadius(25)
        .background(personalColor ? Color(#colorLiteral(red: arrayRGB[0], green: arrayRGB[1], blue: arrayRGB[2], alpha: 1)) : colorPredefined)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .rotation3DEffect(.degrees(cardReversed ? 0 : 360), axis: (x: 0, y: 1, z: 0))
        .shadow(color: .white, radius: 1, x: 3, y: 3)
        .onTapGesture {
            self.cardReversed.toggle()
        }.animation(.easeInOut, value: self.cardReversed)
    }
}


struct CardEditorView_Previws: PreviewProvider {
    static var previews: some View {
        CardEditorView()
            .previewInterfaceOrientation(.portrait)
    }
}
