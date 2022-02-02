//
//  HomeView.swift
//  FirebaseCombine
//
//  Created by PJSMK on 22/01/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Nome: \(sessionService.userDetails?.fullName ?? "N/A")")
                Text("Cpf: \(sessionService.userDetails?.document ?? "N/A")")
                Text("Telefone: \(sessionService.userDetails?.phone ?? "N/A")")
                Text("Aniversario: \(sessionService.userDetails?.birthday ?? "N/A")")
               // Text(" gender: \(sessionService.userDetails?.gender ?? "N/A")")
 
             }
     
            ButtonView(title: "Sair") {
                sessionService.logout()
            }
        }
        .padding(.horizontal, 16)
        .navigationTitle("Home")
     
    }
}

 
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RegisterView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
