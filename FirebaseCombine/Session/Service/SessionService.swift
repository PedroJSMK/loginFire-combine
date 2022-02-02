//
//  SessionService.swift
//  FirebaseCombine
//
//  Created by PJSMK on 22/01/22.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum SessionState {
    case loggeIn
    case loggeOut
}


protocol Sessionservice {
    var state: SessionState {get}
    var userDetails: SessionUserDetails? {get}
    func logout()
    
}

final class SessionServiceImpl: ObservableObject, Sessionservice {
    
    @Published var state: SessionState = .loggeOut
    @Published var userDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
}

private extension SessionServiceImpl {
    
    func setupFirebaseAuthHandler() {
        
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] res, user in
                guard let self = self else { return }
                self.state = user == nil ? .loggeOut : .loggeIn
                if let uid = user?.uid {
                    self.handleRefresh(with: uid)
                }
                
            }
    }
 

    func handleRefresh(with uid: String) {
        
        Database
            .database()
            .reference()
            .child("users")
            .child(uid)
            .observe(.value) { [weak self] snapshot in
                
                guard let self = self,
                      let value = snapshot.value as? NSDictionary,
                      let fullName = value[RegistrationKey.fullName.rawValue] as? String,
                      let document = value[RegistrationKey.document.rawValue] as? String,
                      let birthday = value[RegistrationKey.birthday.rawValue] as? String,
                      let gender = value[RegistrationKey.gender.rawValue] as? Int,
                      let phone = value[RegistrationKey.phone.rawValue] as? String else {
                          return
                      }
                DispatchQueue.main.async {
                    self.userDetails = SessionUserDetails(fullName: fullName,
                                                          document: document,
                                                          phone: phone,
                                                          birthday: birthday,
                                                          gender: gender)
                                                          
                    
                }
            }
        }
}
