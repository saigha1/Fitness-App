//
//  UserProfileIconView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI


struct UserProfileIconView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var shouldShowProfileSheet: Bool = false

    var body: some View {
        Group {
            if let user = authVM.currentEndUser {
                user.profileImage.asProfileImage(45)
                    .onTapGesture {
                        shouldShowProfileSheet.toggle()
                    }
                    .sheet(isPresented: $shouldShowProfileSheet, content: {
                        if #available(iOS 16.0, *) {
                            UserProfileView(user: user)
                                .presentationDetents([.large])
                        } else {
                            // Fallback on earlier versions
                            UserProfileView(user: user)
                        }
                    })
            }
        }
    }
}

struct UserProfileIconView_Previews: PreviewProvider {
    static let authVM = AuthViewModel()
    static var previews: some View {
        if authVM.currentEndUser != nil {
            UserProfileView(user: authVM.currentEndUser!)
                .environmentObject(authVM)
        }
    }
}
