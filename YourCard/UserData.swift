//
//  UserData.swift
//  YourCard
//
//  Created by Jorge Agullo Martin on 22/2/22.
//

import Foundation


//  Clase observable para compartir datos en entorno
class UserData: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var job: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var address: String = ""
    @Published var address2: String = ""
    @Published var dataComplete: Bool = false
    
    //  Función para validar el email
    func textFieldValidatorEmail(_ string: String) -> Bool {

        //  Patrón de comparación para formar un email correcto.
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
        
    }

    //Función de validación para el teléfono
    func textFieldValidatorPhone(_ phone: String) -> Bool {
        //  Se filtra el dato para saber si llegan caracteres alfabéticos o numéricos
        let filtered = "\(phone)".filter {
            "0123456789".contains($0)
            
        }
        if filtered == "\(phone)" {
            return true
        }
        
        return false
    }
    
}
