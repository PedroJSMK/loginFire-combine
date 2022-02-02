//
//  GenderSelectorView.swift
//  FirebaseCombine
//
//  Created by PJSMK on 23/01/22.
//

import SwiftUI

struct GenderSelectorView: View {
    
    @Binding var selectedGender: Gender?
    
    let genders: [Gender]
    let title: String
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.id) { item in
                    
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == item) {
                            selectedGender = item
                        }
                    }
                    
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectorView(selectedGender: .constant(.female), genders: Gender.allCases, title: "Teste")
    }
}
