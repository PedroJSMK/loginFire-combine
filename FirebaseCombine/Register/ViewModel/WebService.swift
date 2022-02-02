//
//  WebService.swift
//  FirebaseCombine
//
//  Created by PJSMK on 27/01/22.
//

import Foundation

enum WebService {
    static func postUser(request: RegistrationModel) {
      guard let jsonData = try? JSONEncoder().encode(request) else { return }
    }
}
