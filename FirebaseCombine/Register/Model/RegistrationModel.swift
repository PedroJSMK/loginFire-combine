//
//  RegistrationModel.swift
//  FirebaseCombine
//
//  Created by PJSMK on 22/01/22.
//

import Foundation

struct RegistrationModel: Encodable {

    var fullName: String
    var email: String
    var password: String
    var document: String
    var phone: String
    var birthday: String
    var gender: Int
}

extension RegistrationModel {
    
   static var new: RegistrationModel {
       RegistrationModel(fullName: "",
                         email: "",
                         password: "",
                          document: "",
                          phone: "",
                          birthday: "",
                          gender: 1)
 
    }
}
