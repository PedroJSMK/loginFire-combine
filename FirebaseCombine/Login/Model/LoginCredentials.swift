//
//  LoginCredentials.swift
//  FirebaseCombine
//
//  Created by PJSMK on 22/01/22.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}
 
extension LoginCredentials {
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
