//
//  RegistrationService.swift
//  FirebaseCombine
//
//  Created by PJSMK on 22/01/22.
//

import SwiftUI
import Foundation
import Combine
import FirebaseDatabase
import Firebase
import FirebaseStorage

enum RegistrationKey: String {
    case fullName
    case document
    case phone
    case birthday
    case gender
    
}

protocol RegistrationService {
    func register(with details: RegistrationModel) -> AnyPublisher<Void, Error>
}

final class RegistrationServiceImpl: RegistrationService {
 
   
   
          
    
   
    func register(with details: RegistrationModel) -> AnyPublisher<Void, Error> {
       
        Deferred {
            Future { promise in
                
                Auth.auth()
                    .createUser(withEmail: details.email, password: details.password) {  res, error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            
                            if let uid = res?.user.uid {
                                let values = [RegistrationKey.fullName.rawValue: details.fullName,
                                              RegistrationKey.document.rawValue: details.document,
                                              RegistrationKey.birthday.rawValue: details.birthday,
                                              RegistrationKey.phone.rawValue: details.phone,
                                           
                                              RegistrationKey.gender.rawValue: details.gender] as [String : Any]
                                                                       
                                Database.database()
                                    .reference()
                                    .child("users")
                                    .child(uid)
                                    .updateChildValues(values) { error, ref in
                                        
                                        if let err = error {
                                            promise(.failure(err))
                                        } else {
                                            promise(.success(()))
                                        }
                                    }
                                
                            } else {
                                promise(.failure(NSError(domain: "ID Usuario invalido", code: 0, userInfo: nil)))
                            }
                        }
                     }
            }
            
        }
        
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
