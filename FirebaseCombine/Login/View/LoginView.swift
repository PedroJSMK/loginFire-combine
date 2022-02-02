//
//  LoginView.swift
//  FirebaseCombine
//
//  Created by PJSMK on 21/01/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    @StateObject private var vm = LoginInViewModelImpl(service: LoginServiceImpl())
    
    var body: some View {
        VStack(spacing: 16) {
            
            VStack(spacing: 16) {
                // emailField
                
                EditTextView(text: $vm.credentials.email,
                             placeholder: "Entre com seu e-mail *",
                             keyboard: .emailAddress,
                             error: "E-mail inválido",
                             failure: !LoginCredentials.new.email.isEmail(),
                             sfSymbol: "envelope" )
                
                
                InputPasswordView(password: $vm.credentials.password,
                                  placeholder: "Senha",
                                  sfSymbol: "lock")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Esqueceu a senha?")
                })
                    .font(.system(size: 16, weight: .bold))
                    .sheet(isPresented: $showForgotPassword,
                           content: {
                        ForgotPasswordView()
                    })
            }
            
            VStack {
                ButtonView(title: "Login") {
                    vm.login()
                }
                
                ButtonView(title:"Realizar cadastro",
                           background: .clear,
                           foregound: .blue,
                           border: .blue) {
                    showRegistration.toggle()
                }
                           .sheet(isPresented: $showRegistration,
                                  content: {
                               RegisterView()
                           })
            }
        }
        .padding(.horizontal)
        .navigationTitle("Login")
        .alert(isPresented: $vm.hasError,
               content: {
            if case .failed(let error) = vm.state {
                return Alert(title: Text("Erro"), message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Erro"), message: Text("Erro login"))
            }
        })
    }
}

extension LoginView {
    var emailField: some View {
        EditTextView(text: $vm.credentials.email,
                     placeholder: "Entre com seu e-mail *",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !LoginCredentials.new.email.isEmail(),
                     sfSymbol: "envelope" )
    }
}

//extension LoginView {
//    var emailField: some View {
//        EditTextView(text: $vm.credentials.email,
//                     placeholder: "E-mail",
//                     keyboard: .emailAddress,
//                     error: "e-mail inválido",
//                     failure: !LoginCredentials.new.email.isEmail(),
//                     sfSymbol: "")
//    }
//}

//extension LoginView {
//    var passwordField: some View {
//        EditTextView(text: $vm.password,
//                     placeholder: "Senha",
//                     keyboard: .emailAddress,
//                     error: "senha deve ter ao menos 8 caracteres",
//                     failure:  vm.password.count < 8,
//                     isSecure: true)
//    }
//}
//

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            LoginView()
                .previewDevice("iPhone 11")
                .preferredColorScheme($0)
        }
        
    }
}
