//
//  FireBaseSignInWithAppleView.swift
//  Fitness_App
//
//  Created by Xavier on 2/2/23.
//

import SwiftUI
import AuthenticationServices

struct FireBaseSignInWithAppleView: View {
    /// Environment properties that detects the UI appearance, used for style of SignInWithAppleButton
    @Environment(\.colorScheme) var colorScheme
    
//    @StateObject private var vm = FireBaseSignInWithAppleViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack {
            signInButton
            if authVM.authState == .authenticated {
                greeting
                signOutButton
            }
        }
    }
}

struct FireBaseSignInWithAppleView_Previews: PreviewProvider {
    static var previews: some View {
        FireBaseSignInWithAppleView()
            .environmentObject(AuthViewModel())
    }
}

extension FireBaseSignInWithAppleView {
    private var signInButton: some View {
        SignInWithAppleButton(
            onRequest: { request in
                authVM.handleSignInWithAppleRequest(request)
            },
            onCompletion: { result in
                authVM.handleSignInWithAppleCompletion(result)
            }
        )
        .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
        .frame(width: 200, height: 60)
        .cornerRadius(8)
    }
    
    private var greeting: some View {
        Text("Hello \(authVM.displayName)!")
    }
    
    private var signOutButton: some View {
        Button {
            authVM.signOut()
        } label: {
            Text("Sign Out")
                .foregroundColor(.red)
                .bold()
                .font(.title3)
                .frame(width: 300, height: 60, alignment: .center)
        }
    }
}
