//
//  Google-Firebase-LoginVM.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-02.
//

import Foundation
import SwiftUI

import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import FirebaseAuth
import Firebase
import UIKit

class GoogleSignInWithFirebase: ObservableObject{
    @Published var isMFAEnabled : Bool = false
    @Published var isPresented : Bool = false
    
    
    init() {
        self.isMFAEnabled = isMFAEnabled
    }
    //protocol like functions required for the next function to work
    private func showTextInputPrompt(withMessage message: String,
                                     completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = weakPrompt?.textFields?.first?.text else { return }
            completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        //       present(prompt, animated: true, completion: nil)
        isPresented = true
        
    }
    
    //protocol like functions required for the next function to work
    private func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        //        present(alert, animated: false, completion: nil)
        isPresented = true
        
    }
    
    func handleSignInButton() {
        print("Sign-in with Google Clicked")
        
        //For Sign-in with Google and OAuth2 only
        //        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
        //          print("There is no root view controller!")
        //          return
        //        }
        //
        //        GIDSignIn.sharedInstance.signIn(
        //            withPresenting: rootViewController) { signInResult, error in
        //              guard let result = signInResult else {
        //                // Inspect error
        //                  print("Error signing in")
        //                return
        //              }
        //              // If sign in succeeded, display the app's main content View.
        //                print("Sign-in successful")
        //            }
        //    }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { [unowned self] user, error in
            
            if let error = error {
                // ...
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in     //Authentication code for Google Sign In
                if let error = error {
                    let authError = error as! NSError
                    if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                        // The user is a multi-factor user. Second factor challenge is required.
                        let resolver = authError
                            .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                        var displayNameString = ""
                        for tmpFactorInfo in resolver.hints {
                            displayNameString += tmpFactorInfo.displayName ?? ""
                            displayNameString += " "
                        }
                        self.showTextInputPrompt(
                            withMessage: "Select factor to sign in\n\(displayNameString)",
                            completionBlock: { userPressedOK, displayName in
                                var selectedHint: PhoneMultiFactorInfo?
                                for tmpFactorInfo in resolver.hints {
                                    if displayName == tmpFactorInfo.displayName {
                                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                                    }
                                }
                                PhoneAuthProvider.provider()
                                    .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                                                       multiFactorSession: resolver
                                        .session) { verificationID, error in
                                            if error != nil {
                                                print(
                                                    "Multi factor start sign in failed. Error: \(error.debugDescription)"
                                                )
                                            } else {
                                                self.showTextInputPrompt(
                                                    withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
                                                    completionBlock: { userPressedOK, verificationCode in
                                                        let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                                                            .credential(withVerificationID: verificationID!,
                                                                        verificationCode: verificationCode!)
                                                        let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                                                            .assertion(with: credential!)
                                                        resolver.resolveSignIn(with: assertion!) { authResult, error in
                                                            if error != nil {
                                                                print(
                                                                    "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                                                                )
                                                            } else {
//                                                                self.navigationController?.popViewController(animated: true)
                                                                
                                                            }
                                                        }
                                                    }
                                                )
                                            }
                                        }
                            }
                        )
                    } else {
                        self.showMessagePrompt(error.localizedDescription)
                        return
                    }
                    // ...
                    return
                }
                // User is signed in
                print("User signed in with Google using Firebase Authentication!")
                
                ///For signing out
                //              let firebaseAuth = Auth.auth()
                //                do {
                //                  try firebaseAuth.signOut()
                //                } catch let signOutError as NSError {
                //                  print("Error signing out: %@", signOutError)
                //                }
                
            }
        }
        
        
        
    }
    
    
}
