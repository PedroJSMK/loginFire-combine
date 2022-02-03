//
//  RegistrationViewModel.swift
//  FirebaseCombine
//
//  Created by PJSMK on 22/01/22.
//

import Foundation
import Combine
import SwiftUI
import FirebaseStorage

enum RegistrationState {
    case successfull
    case failed(error: Error)
    case na
}

protocol RegistrationViewModel {
    func register()
    var hasError: Bool {get}
    var service: RegistrationService { get }
    var state: RegistrationState { get }
    var userDetails: RegistrationModel { get }
    init(service: RegistrationService)
}


final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
       
    @Published var hasError: Bool = false
    @Published var state: RegistrationState = .na
    
    @Published var image = UIImage()
    @Published var formInvalid = false
    @Published var birthday = ""
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
     @Published var gender = Gender.male
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    

    let service: RegistrationService
    
    var userDetails: RegistrationModel = RegistrationModel.new
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: RegistrationService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func register() {
        
 
        func uploadPhoto() {
            let filename = UUID().uuidString
            
            guard let data = image.jpegData(compressionQuality: 0.2) else { return }
            
            let newMetadata = StorageMetadata()
            
            let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
            
            ref.putData(data, metadata: newMetadata) { metadata, err in
                ref.downloadURL { url, error in
                    self.state = .successfull
                    
                }
            }
        }
        
        if(image.size.width <= 0) {
            formInvalid = true
             
            self.state = .failed(error: "Selecione uma foto" as! Error)
            return
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)

        guard let dateFormatted = dateFormatted else {
            self.state = .failed(error: "Data inválida \(birthday)" as! Error)
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
         let birthday = formatter.string(from: dateFormatted)
        
         userDetails = RegistrationModel(fullName: fullName,
                                         email: email,
                                         password: password,
                                         document: document,
                                         phone: phone,
                                         birthday: birthday,
                                         gender: gender.index)
        service
            .register(with: userDetails)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscriptions)
        
     
    }
    
}

private extension RegistrationViewModelImpl {
    
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfull,
                        .na:
                    return false
                    
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}

 
