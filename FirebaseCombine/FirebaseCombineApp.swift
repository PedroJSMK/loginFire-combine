//
//  FirebaseCombineApp.swift
//  FirebaseCombine
//
//  Created by PJSMK on 21/01/22.
//

import SwiftUI
import Firebase


@main
struct FirebaseCombineApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                switch sessionService.state {
                case .loggeIn: HomeView()
                        .environmentObject(sessionService)
                case .loggeOut: LoginView()
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
