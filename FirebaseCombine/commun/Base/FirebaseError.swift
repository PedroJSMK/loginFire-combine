//
//  FirebaseError.swift
//  FirebaseCombine
//
//  Created by PJSMK on 01/02/22.
//

import Foundation

public enum FirebaseError: Error {
    case alreadySignedIn
    case noUid
    case noQuerySnapshot
    case noDocumentSnapshot
    case documentDoesNotExist
    case noAuthDataResult
    case noProfile
    case noImageAvailable
    case noUrl
    case noData
    case somethingWentWrong
    case custom(description: String, code: Int)
    
}

extension FirebaseError {
    public var code: Int {
        switch self {
        case .alreadySignedIn:
            return 0
        case .noUid:
            return 1
        case .noQuerySnapshot:
            return 2
        case .noDocumentSnapshot:
            return 3
        case .documentDoesNotExist:
            return 4
        case .noAuthDataResult:
            return 5
        case .noProfile:
            return 6
        case .noImageAvailable:
            return 7
        case .noUrl:
            return 8
        case .noData:
            return 9
        case .somethingWentWrong:
            return 10
        case .custom(description: _, code: let code):
            return code
         
            
        }
    }
}

extension FirebaseError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .alreadySignedIn:
            return "Already signed in"
        case .noUid:
            return "No Uid"
        case .noQuerySnapshot:
            return "No query snapshot"
        case .noDocumentSnapshot:
            return "No document snapshot"
        case .documentDoesNotExist:
            return "Document does not exist"
        case .noAuthDataResult:
            return "No auth data result"
        case .noProfile:
            return "No profile"
        case .noImageAvailable:
            return "No image available"
        case .noUrl:
            return "No URL"
        case .noData:
            return "No data"
        case .somethingWentWrong:
            return "Something went wrong"
        case .custom(description: let description, code: _):
            return description
        }
    }
}

extension FirebaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .alreadySignedIn:
            return NSLocalizedString("Already signed in.", comment: "Already signed in")
        case .noUid:
            return NSLocalizedString("No Uid.", comment: "No Uid")
        case .noQuerySnapshot:
            return NSLocalizedString("No query snapshot.", comment: "No query snapshot")
        case .noDocumentSnapshot:
            return NSLocalizedString("No document snapshot.", comment: "No document snapshot")
        case .documentDoesNotExist:
            return NSLocalizedString("Document does not exist.", comment: "Document does not exist")
        case .noAuthDataResult:
            return NSLocalizedString("No auth data result.", comment: "No auth data result")
        case .noProfile:
            return NSLocalizedString("No profile.", comment: "No profile")
        case .noImageAvailable:
            return NSLocalizedString("No image available.", comment: "No image available")
        case .noUrl:
            return NSLocalizedString("No URL.", comment: "No URL")
        case .noData:
            return NSLocalizedString("No data.", comment: "No data")
        case .somethingWentWrong:
            return NSLocalizedString("Something went wrong.", comment: "Something went wrong")
        case .custom(description: let description, code: _):
            return NSLocalizedString(description, comment: description)
        }
    }
}
