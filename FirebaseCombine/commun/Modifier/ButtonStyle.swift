//
//  ButtonStyle.swift
//  TesteLealApps (iOS)
//
//  Created by PJSMK on 06/01/22.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity)
      .padding(.vertical, 14)
      .padding(.horizontal, 16)
      .font(Font.system(.title3).bold())
      .background(Color.orange)
      .foregroundColor(.white)
      .cornerRadius(4.0)
  }
  
}
