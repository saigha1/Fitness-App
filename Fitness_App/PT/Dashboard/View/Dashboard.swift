//
//  Dashboard.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-13.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var authVM : AuthViewModel

    var body: some View {
        VStack{
            Text("Welcome to Dashboard!")
            
            Button {
                authVM.signOut()
            } label: {
                Text("Sign Out")
            }

        }
        
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
            .environmentObject(AuthViewModel())
    }
}
