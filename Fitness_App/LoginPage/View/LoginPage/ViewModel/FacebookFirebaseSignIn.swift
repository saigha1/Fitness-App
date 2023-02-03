//
//  FacebookFirebaseSignIn.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-02.
//

import Foundation
import SwiftUI
import FacebookLogin
import FacebookCore
import FirebaseFirestore
import FirebaseAuth


class UserLoginManager: ObservableObject {
    let loginManager = LoginManager()
    @Published var isMFAEnabled = false
    @Published var isPresented = false
    
    
    /*! @fn showTextInputPromptWithMessage
      @brief Shows a prompt with a text field and 'OK'/'Cancel' buttons.
      @param message The message to display.
      @param completion A block to call when the user taps 'OK' or 'Cancel'.
      */
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
    
    
    func facebookLogin() {
        
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in //API call for FB-login
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        
                        let fbDetails = result as! NSDictionary
                        print(fbDetails)
                        let credential = FacebookAuthProvider
                          .credential(withAccessToken: AccessToken.current!.tokenString)
                        
                        
                        Auth.auth().signIn(with: credential) { authResult, error in     //Authentication using Firebase
                            if let error = error {
                                let authError = error as NSError
                                if self.isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
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
//                                                  self.navigationController?.popViewController(animated: true)
                                                    
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
                            // ...
                            print("User is signed in using FB-Firebase. --")
                        }
                    }
                })
                
                
            }
        }
    }
}
