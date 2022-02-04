//
//  RegisterButtonView.swift
//  FirebaseCombine
//
//  Created by PJSMK on 04/02/22.
//

import SwiftUI

struct RegisterButtonView: View {
  
  var action: () -> Void
  var text: String
  var showProgress: Bool = false
  var disabled: Bool = false
  
  var body: some View {
    ZStack {
      Button(action: {
        action()
      }, label: {
        Text(showProgress ? " " : text)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 14)
          .padding(.horizontal, 16)
          .font(Font.system(.title3).bold())
          .background(disabled ? Color("RegisterButton") : Color.orange)
          .foregroundColor(.white)
          .cornerRadius(4.0)
      }).disabled(disabled || showProgress)
      
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle())
        .opacity(showProgress ? 1 : 0)
    }
  }
}

struct RegisterButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      VStack {
          RegisterButtonView(action: {
          print("ola mundo")
        },
        text: "Entrar",
        showProgress: false,
        disabled: false)
      }.padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .previewDevice("iPhone 11")
      .preferredColorScheme($0)
    }
    
  }
}
