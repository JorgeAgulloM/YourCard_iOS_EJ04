//
//  SplashScreen.swift
//  YourCard
//
//  Created by Jorge Agullo Martin on 14/2/22.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    var body: some View {
        VStack{
            if self.isActive {
                NavigatorView()
            } else {
                Image("yourCards")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 400)
            
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreen_Previws: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(UserData())
    }
}
