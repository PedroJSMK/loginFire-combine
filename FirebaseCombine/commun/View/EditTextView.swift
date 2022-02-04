//
//  EditTextView.swift
//  TesteLealApps (iOS)
//
//  Created by PJSMK on 06/01/22.
//
   
import SwiftUI

struct EditTextView: View {
  
    @Binding var text: String
     private let textFieldLeading: CGFloat = 30
   

    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autocapitalization: UITextAutocapitalizationType = .none
     let sfSymbol: String?

  var body: some View {
    VStack {
      if isSecure {
          SecureField(placeholder, text: $text)
          
              .foregroundColor(Color("textColor"))
          .keyboardType(keyboard)
          .textFieldStyle(CustomTextFieldStyle())
          .font(.system(size: 15, weight: .bold, design: .default))
          .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
      } else {
        TextField(placeholder, text: $text)
          .foregroundColor(Color("textColor"))
          .keyboardType(keyboard)
          .textFieldStyle(CustomTextFieldStyle())
          .font(.system(size: 15, weight: .bold, design: .default))
          .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
          .autocapitalization(autocapitalization)
          .background(
              ZStack(alignment: .leading) {
                  if let systemImage = sfSymbol {
                      Image(systemName: systemImage)
                          .font(.system(size: 16, weight: .semibold))
                          .padding(.leading, 5)
                          .foregroundColor(Color.gray.opacity(0.5))
                  }
                  RoundedRectangle(cornerRadius: 10,
                                   style: .continuous)
                      .stroke(Color.gray.opacity(0.25))
              }
          )
          .onChange(of: text) { value in
            if let mask = mask {
              Mask.mask(mask: mask, value: value, text: &text)
            }
              
          }
      }
            
      if let error = error, failure == true, !text.isEmpty {
          Text(error).foregroundColor(.red)
      }
    }
    .padding(.bottom, 10)
  }
}


struct EditTextView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      VStack {
        EditTextView(text: .constant("Texto"),
                     placeholder: "E-mail",
                     error: "Campo inválido",
                     failure: "a@a.com".count < 3,
                      sfSymbol: ""
        )
          .padding()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .previewDevice("iPhone 11")
      .preferredColorScheme($0)
    }
  }
}
