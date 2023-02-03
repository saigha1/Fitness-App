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
    
    @EnvironmentObject var vm: FireBaseSignInWithEmailViewModel
    
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
            .environmentObject(AuthenticationViewModel())
    }
}

extension FireBaseSignInWithEmailView {
    private var form: some View {
        VStack {
            TextField("Your Email", text: $vm.email)
            SecureField("Password", text: $vm.password)
            signInButton
            Spacer()
        }
        .frame(height: 300)
        .padding()
    }
    
    private var signInButton: some View {
        Button {
            Task {
                if !(await vm.signInWithEmail()) {
                    let _ = await vm.signUpWithEmail()
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
