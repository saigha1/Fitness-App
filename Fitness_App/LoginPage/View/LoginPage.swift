//
//  LoginPage.swift
//  Fitness_App
//
//  Created by MAC on 2023-01-25.
//

import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            
            
            Text("Sign In")
                .underline()
            
            Text("Sign in with Facebook").bold() //Step 1: FB w/ cocoa pods and Oauth2
            Text("Sign in with GMail").bold()   //Step 2: GMail wth Oauth2
            Text ("Sign in with Apple").bold()  //Step 3: Apple wiith Oauth2
               
            Text("Sign in with Regular Email").bold() .padding(5) //Step 4: Might not need Oauth2 Firebase maybe
            
            Text("Enter your Email: ")
                .bold()
                .frame(alignment: .center)
            
            TextFieldView(textInput: $email, placeholder: "Email", isPassword: false)
                
            TextFieldView(textInput: $password, placeholder: "Password: ", isPassword: true)
            
                
            
            
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
