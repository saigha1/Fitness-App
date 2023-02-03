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


///Refactored Code for Google Sign In and Facebook Sign In
///Enabled Firebase for Google and now Facebook
///

struct LoginPage: View {    
//    @State private var email = ""
//    @State private var password = ""
    let loginButton = FBLoginButton()
  
    
//    @EnvironmentObject var GoogleFirebaseSignIn : GoogleSignInWithFirebase
//    @EnvironmentObject var FacebookFirebaseSignIn: UserLoginManager
    @EnvironmentObject var authVM: AuthViewModel
    
    @MainActor
    var body: some View {
        VStack{
            if authVM.isPresented{
                Text("Welcome Facebook-Firebase")
            }
                
            Text("Sign In").bold()
                .underline()
            
            
            Button(action: {
                self.authVM.facebookLogin()
            }) {
                Text("Continue with Facebook")
            }
            .background(.pink)
 
            GoogleSignInButton(action: authVM.handleSignInWithGoogleButton)
                .frame(width: 200)
            
//            Text ("Sign in with Apple").bold()  //Step 3: Apple wiith Oauth2
            FireBaseSignInWithAppleView()
            
            Text("Sign in with Regular Email").bold().underline() .padding(5) //Step 4: Might not need Oauth2 Firebase maybe
            
//            Text("Enter your Email: ")
//                .bold()
//                .frame(alignment: .center)
//
//            TextFieldView(textInput: $email, placeholder: "Email", isPassword: false)
//
//            TextFieldView(textInput: $password, placeholder: "Password: ", isPassword: true)
            FireBaseSignInWithEmailView()
            
        }
    }
}



struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
