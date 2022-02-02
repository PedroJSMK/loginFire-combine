//
//  ForgotPasswordView.swift
//  FirebaseCombine
//
//  Created by PJSMK on 22/01/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = ForgotPasswordViewModelImpl( service: ForgotPasswordServiceImpl())
    
    var body: some View {
        VStack(spacing: 16) {
            EditTextView(text: $vm.email,
                               placeholder: "Email",
                               keyboard: .emailAddress,
                             sfSymbol: "envelope")
            
            ButtonView(title: "Redefinir senha")    {
                vm.sendPasswordReset()
                presentationMode.wrappedValue.dismiss()
                
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Redefinir senha")
        .applyClose()

    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
