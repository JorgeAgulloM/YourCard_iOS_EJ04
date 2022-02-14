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
    
    @State var personalColor: Bool = false
    @State var scaleCircles: Double = 0.6
    @State var logoColorSelect: Color = Color.white
    @State var foreColorSelect: Color = Color.black
    @State var finalColor: Color = Color.blue
    @State var colorPresed: Int = 2
    @State var cardReversed: Bool = false
    @State var aluminio: Bool = true
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                CardView(finalColor: finalColor,
                         foreColorSelect: foreColorSelect,
                         logoColorSelect: logoColorSelect,
                         aluminio: aluminio,
                         cardReversed: $cardReversed)
                    
                
                
                Text("Selecciona tu color")
                    .font(.title2)
                    .padding(10)
                    .foregroundColor(Color.black)
                
                
                HStack(alignment: .center, spacing: 40){
                    ForEach(0..<5, id:\.self) { id in
                        ColorSelector(id: id,
                                      finalColor: $finalColor,
                                      colorPresed: $colorPresed)
                            
                    }.padding(.top, 10)
                        
                }
                .padding(.horizontal, 35)
                .foregroundColor(Color.white)
                .frame(width: 300, height: 100, alignment: .leading)
                .accessibilityHidden(personalColor)
                
                Toggle(isOn: $aluminio) {
                    Text("¿Plástico o Aluminio?")
                    }.padding()
                    .frame(width: 300, height: 30, alignment: .center)
                    .foregroundColor(Color.black)
                
                Text("Puedes personalizarla a tu gusto")
                    .padding()
                    .font(.title3)
                ColorPicker("Elige tu propio color de fondo", selection: $finalColor)
                    .padding()
                    .frame(width: 300, height: 30, alignment: .center)
                    .foregroundColor(Color.black)
                ColorPicker("Elige el color del logo", selection: $logoColorSelect)
                    .padding()
                    .frame(width: 300, height: 30, alignment: .center)
                    .foregroundColor(Color.black)
                Text("Puedes elegir el color de la letra")
                    .padding()
                    .font(.title3)
                ColorPicker("Elige el color de la letra", selection: $foreColorSelect)
                    .padding()
                    .frame(width: 300, height: 30, alignment: .center)
                    .foregroundColor(Color.black)
                
                
                
                //Spacer()
            }.frame(width: .infinity, height: .infinity, alignment: .center)
        }
    }
}

struct CardEditorView_Previws: PreviewProvider {
    static var previews: some View {
        CardEditorView()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(UserData())
    }
}
