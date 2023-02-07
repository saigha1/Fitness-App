//
//  LoginPage.swift
//  Fitness_App
//
//  Created by MAC on 2023-01-25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FacebookLogin
import FacebookCore
import Foundation
import FirebaseCore
import FirebaseAuth
import UIKit


///Refactored Code for Google Sign In and Facebook Sign In
///Enabled Firebase for Google and now Facebook
///

struct LoginPage: View {

    @EnvironmentObject var authVM: AuthViewModel
    
    @MainActor
    var body: some View {
        ZStack{
            Image("Sign-in-bgimage")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height, alignment: .center)
                .scaledToFit()
                .ignoresSafeArea()
                .overlay() {
                    Color(white: 1, opacity: 0.8).ignoresSafeArea()
                }
            
            VStack{
                Text("Sign In").bold()
                
                //Email Login
                FireBaseSignInWithEmailView()
                
                Divider()
                    .frame(minHeight: 0.8)
                    .frame(width: 150)
                    .background(Color.gray)
                
                Spacer()
                    .frame(height: 20)
                
                //Facebook Login Button
                Button(action: {
                    self.authVM.facebookLogin()
                }) {
                    facebookLogin()
                }
                .frame(width: 220, height: 50, alignment: .center)
                .cornerRadius(4)
                
                Spacer()
                    .frame(height: 8)
                
                //Google Login Button
                GoogleSignInButton(action: authVM.handleSignInWithGoogleButton)
                    .frame(width: 220)
                
                
                //Apple Login Button
                FireBaseSignInWithAppleView()
            }
        }
    }
}



struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .environmentObject(AuthViewModel())
    }
}
