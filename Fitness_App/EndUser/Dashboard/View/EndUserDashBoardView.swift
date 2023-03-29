//
//  EndUserDashBoardView.swift
//  Fitness_App
//
//  Created by Xavier on 2/27/23.
//

import SwiftUI

struct EndUserDashBoardView: View {
    @EnvironmentObject var authVM : AuthViewModel
    var body: some View {
        NavigationView {
            content
        }
    }
}

struct EndUserDashBoardView_Previews: PreviewProvider {

    
    static var previews: some View {
        EndUserDashBoardView()
            .environmentObject(AuthViewModel())
    }
}

extension EndUserDashBoardView {
    private var content: some View {
        VStack {
            Button {
                authVM.signOut()
            } label: {
                Text("Sign Out")
            }
            Text("Dashboard contents goes here")
        }
        .navigationTitle("Dashboard")
        .toolbar {
            ToolbarItem {
                UserProfileIconView()
                    .environmentObject(authVM)
            }
        }
    }
}
