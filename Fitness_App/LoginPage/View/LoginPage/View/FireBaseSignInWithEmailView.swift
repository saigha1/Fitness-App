//
//  FireBaseSignInWithEmailView.swift
//  Fitness_App
//
//  Created by Xavier on 2/2/23.
//

import SwiftUI

struct FireBaseSignInWithEmailView: View {
    /// Environment properties that detects the UI appearance, used for style of SignInWithAppleButton
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @MainActor
    var body: some View {
        VStack {
            form
            
        }
    }
}

struct FireBaseSignInWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        FireBaseSignInWithEmailView()
            .environmentObject(AuthViewModel())
    }
}

extension FireBaseSignInWithEmailView {
    private var form: some View {
        VStack {
            TextField("Your Email", text: $authVM.email)
            SecureField("Password", text: $authVM.password)
            signInButton
            Spacer()
        }
        .frame(height: 300)
        .padding()
    }
    
    private var signInButton: some View {
        Button {
            Task {
                if !(await authVM.signInWithEmail()) {
                    let _ = await authVM.signUpWithEmail()
                }
            }
        } label: {
            HStack {
                Image(systemName: "envelope")
                Text("Sign in with Email")
                    .bold()
            }
            .padding()
            .foregroundColor(colorScheme == .light ? Color.white : Color.black)
            .frame(width: 240, height: 60)
            .background(colorScheme == .light ? Color.black : Color.white)
            .cornerRadius(8)
        }
    }
}
