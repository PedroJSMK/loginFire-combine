//
//  Date+Extension.swift
//  TesteLealApps (iOS)
//
//  Created by PJSMK on 06/01/22.
//

import Foundation

extension Date {
  
  func toString(destPattern dest: String) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = dest
    
    return formatter.string(from: self)
  }
  
}
