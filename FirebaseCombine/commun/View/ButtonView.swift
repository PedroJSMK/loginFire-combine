//
//  ButtonComponentView.swift
//  FirebaseCombine
//
//  Created by PJSMK on 21/01/22.
//

import SwiftUI
import CoreMedia

struct ButtonView: View {
   
    typealias ActionHandler = () -> Void
    
    let title: String
    let background: Color
    let foregound: Color
    let border: Color
    let handler: ActionHandler
    var disabled: Bool = false
    var showProgress: Bool = false

    private let cornerRadius: CGFloat = 10
    
    
    internal init(title: String,
                  background: Color = .blue,
                  foregound: Color = .white,
                  border: Color = .clear, handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.background = background
        self.foregound = foregound
        self.border = border
        self.handler = handler
    }
     
    
    var body: some View {
        Button(action: handler, label: {
            Text(title)
                .frame(maxWidth: .infinity,
                       maxHeight: 50)
        }).disabled(disabled || showProgress)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(disabled ? Color("lightOrange") : Color.orange)
            .foregroundColor(.white)
            .cornerRadius(4.0)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(border, lineWidth: 2))
        
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
          .opacity(showProgress ? 1 : 0)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonView(title: "Botao 1") {}
                .preview(with: "botao 1")
        ButtonView(title: "botao 2",
                   background: .clear,
                   foregound: .blue,
                   border: .blue) {}
                   .preview(with: "botao2")
             
        
        }
    }
}
