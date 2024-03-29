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

    //  Variable de entrono
    @EnvironmentObject var userData: UserData
    
    //  Propiedades de la vista
    @State var personalColor: Bool = false
    @State var scaleCircles: Double = 0.6
    @State var logoColorSelect: Color = Color.white
    @State var foreColorSelect: Color = Color.black
    @State var finalColor: Color = Color.blue
    @State var colorPresed: Int = 2
    @State var cardReversed: Bool = false
    @State var cardSelect: Bool = false
    @State var aluminum: Bool = true
    @State var sendCard: Bool = false
    @State var sendBy: Bool = false

    var body: some View {
        ScrollView {
            //  Cuerpo de la tarjeta
            VStack(alignment: .center) {
                CardView(finalColor: finalColor,
                         foreColorSelect: foreColorSelect,
                         logoColorSelect: logoColorSelect,
                         aluminum: aluminum,
                         cardReversed: $cardReversed)
                    
                Text("Selecciona tu color")
                    .font(.title2)
                    .padding(10)
                    .foregroundColor(Color.black)
                
                //  Selector de color predefinido
                HStack(alignment: .center, spacing: 40){
                    ForEach(0..<5, id:\.self) { id in
                        ColorSelector(id: id,
                                      finalColor: $finalColor,
                                      colorPresed: $colorPresed,
                                      cardSelect: $cardSelect)
                            
                    }.padding(.top, 10)
                        
                }
                .padding(.horizontal, 35)
                .foregroundColor(Color.white)
                .frame(width: 320, height: 100, alignment: .leading)
                .accessibilityHidden(personalColor)
                
                UserOptions(aluminio: $aluminum,
                            finalColor: $finalColor,
                            logoColorSelect: $logoColorSelect,
                            foreColorSelect: $foreColorSelect)
            
                Button("Enviar tarjeta") {
                    self.sendCard = true
                    
                }.padding(.top, 30)
                    .actionSheet(isPresented: $sendCard) {
                    ActionSheet(title: Text("Opciones de envío"),
                                message: Text("¿Como quieres enviar la tarjeta?"),
                                buttons: [
                                    .default(Text("Por email"), action: {
                                        self.sendBy = true
                                    }),
                                    .default(Text("Imprimirla"), action: {
                                        self.sendBy = true
                                    }),
                                    .destructive(Text("Cancelar"))
                                    
                                ])
                        
                        //  Alert para elegir el sistema de envío (Aún no funciona)
                    }.alert(isPresented: $sendBy) {
                        Alert(title: Text("Enviar...")
                                .font(.title3),
                              message: Text("Te pedimos disculpas, estamos trabajando en esta funcionalidad. Podrás disfrutarás de ella próximamente.")
                                .font(.title2))
                        
                    }
                
            }._automaticPadding()
        }._automaticPadding()
    }
}

//  Opciones de usuario
struct UserOptions: View {
    //  Propiedades del objeto
    @Binding var aluminio: Bool
    @Binding var finalColor: Color
    @Binding var logoColorSelect: Color
    @Binding var foreColorSelect: Color
    
    var body: some View {
        Toggle(isOn: $aluminio) {
            Text("¿Plástico o Aluminio?")
        }.padding(.top, 30)
            .padding(.horizontal, 10)
            .frame(width: 300, height: 30, alignment: .center)
            .foregroundColor(Color.black)
        
        Text("Puedes personalizarla a tu gusto")
            .padding()
            .font(.title3)
        
        ColorPicker("Elige tu propio color de fondo", selection: $finalColor)
            .padding()
            .frame(width: 300, height: 30, alignment: .center)
            .foregroundColor(Color.black)
        
        ColorPicker("Elige el color para el logo", selection: $logoColorSelect)
            .padding()
            .frame(width: 300, height: 30, alignment: .center)
            .foregroundColor(Color.black)
        
        ColorPicker("Elige el color del texto", selection: $foreColorSelect)
            .padding()
            .frame(width: 300, height: 30, alignment: .center)
            .foregroundColor(Color.black)
    }
}

struct CardEditorView_Previws: PreviewProvider {
    static var previews: some View {
        CardEditorView()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(UserData())
    }
}
