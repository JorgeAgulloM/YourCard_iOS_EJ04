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

    @State var nombre: String = ""
    @State var apellidos: String = ""
    @State var puestoTrabajo: String = ""
    @State var telefono: String = ""
    @State var email: String = ""
    @State var direccion: String = ""
    @State var direccion2: String = ""
    
    /**
     CGRect screenRect = [[UIScreen mainScreen] bounds];
     CGFloat screenWidth = screenRect.size.width;
     CGFloat screenHeight = screenRect.size.height;
     */
    
    
    
    var sizeScreenWidth = UIScreen.main.bounds.width
    var sizeScreenHeigth = UIScreen.main.bounds.height
    @State var colorSliderRed: Float = 0.0
    @State var colorSliderBlue: Float = 0.0
    @State var colorSliderGreen: Float = 0.0
    @State var personalColor: Bool = false
    @State var scaleCircles: Double = 0.6
    let colorPredefined: Array<Color> = [Color.yellow, Color.red, Color.gray, Color.green, Color.blue, Color.orange]
    @State var colorPresed: Int = 0
    @State var cardReversed: Bool = false
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Text("Personaliza el color")
                    .padding(.top, 50)
                    .font(.largeTitle)
                    .foregroundColor(Color.blue)
                VStack {
                    Text("Elige el color de tu tarjeta")
                        .padding()
                        .font(.title)
                    Toggle(isOn: $personalColor) {
                        Text("Personalizar?")
                    }.padding(.horizontal, 80)
                    
                    if personalColor {
                        VStack {
                            Slider(value: $colorSliderRed)
                                .padding(.horizontal)
                                .foregroundColor(Color.red)
                            Slider(value: $colorSliderGreen)
                                .padding(.horizontal)
                            Slider(value: $colorSliderBlue)
                                .padding(.horizontal)
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
                }.frame(width: (sizeScreenWidth * 0.9), height: (sizeScreenHeigth * 0.3))
                    .cornerRadius(25)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .accessibilityHidden(personalColor)
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
                                        Text("Jorge Agulló")
                                        Text("Desarrollador iOS")
                                    }.font(.title)
                                        .foregroundColor(Color.black)
                                }
                            } else {
                                Section{
                                    Text("653912277")
                                    Text("agullojorge@gmail.com")
                                    Text("Calle de elche 17 3 3")
                                }
                                .font(.title)
                                
                            }
                             
                        }
                        Image("aluminio")
                            .opacity(0.6)
                            
                    }
                }.frame(width: (sizeScreenWidth * 0.9), height: (sizeScreenHeigth * 0.3))
                    .cornerRadius(25)
                    .background(personalColor ? Color(#colorLiteral(red: colorSliderRed, green: colorSliderGreen, blue: colorSliderBlue, alpha: 1)) : colorPredefined[colorPresed])
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .rotation3DEffect(.degrees(cardReversed ? 0 : 360), axis: (x: 0, y: 1, z: 0))
                    .onTapGesture {
                        self.cardReversed.toggle()
                    }.animation(.easeInOut, value: self.cardReversed)
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
            .shadow(color: .black, radius: colorPresed == id ? 2 : 10)
            .onTapGesture {
                colorPresed = id
            }
    }
    
}

struct CardEditorView_Previws: PreviewProvider {
    static var previews: some View {
        CardEditorView()
            .previewInterfaceOrientation(.portrait)
    }
}
