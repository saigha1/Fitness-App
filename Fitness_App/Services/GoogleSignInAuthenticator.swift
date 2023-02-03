//
//  GoogleSignInAuthenticator.swift
//  Fitness_App
//
//  Created by MAC on 2023-01-30.
//
import GoogleSignIn
import Foundation
import Firebase

final class GoogleSignInAuthenticator: ObservableObject {
    private var authViewModel: AuthenticationViewModel
    
    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
    }
    /// Signs in the user based upon the selected account.'
    /// - note: Successful calls to this will set the `authViewModel`'s `state` property.
    func signIn() {
  #if os(iOS)
      guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
        print("There is no root view controller!")
        return
      }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration(clientID: clientID), presenting: rootViewController) { signInResult, error in
          guard let signInResult = signInResult else {
            print("Error! \(String(describing: error))")
            return
          }
          //self.authViewModel.state = .signedIn(signInResult.user)
            self.authViewModel.state = .signedIn(signInResult)
        }


//      GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
//        guard let signInResult = signInResult else {
//          print("Error! \(String(describing: error))")
//          return
//        }
//        self.authViewModel.state = .signedIn(signInResult.user)
//      }
///NOT CURRENTLY NEEDED=> ONLY FOR MacOS
//  #elseif os(macOS)
//      guard let presentingWindow = NSApplication.shared.windows.first else {
//        print("There is no presenting window!")
//        return
//      }
//
//      GIDSignIn.sharedInstance.signIn(withPresenting: presentingWindow) { signInResult, error in
//        guard let signInResult = signInResult else {
//          print("Error! \(String(describing: error))")
//          return
//        }
//        self.authViewModel.state = .signedIn(signInResult.user)
//      }
  #endif
    }
    
    /// Signs out the current user.
    func signOut() {
      GIDSignIn.sharedInstance.signOut()
      authViewModel.state = .signedOut
    }
    
    /// Disconnects the previously granted scope and signs the user out.
    func disconnect() {
      GIDSignIn.sharedInstance.disconnect { error in
        if let error = error {
          print("Encountered error disconnecting scope: \(error).")
        }
        self.signOut()
      }
    }
    
    
}
