//
//  AuthViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 2/3/23.
//

import Foundation
import Firebase
import AuthenticationServices
import CryptoKit
import SwiftUI
import FacebookLogin
import FacebookCore
import GoogleSignIn
import GoogleSignInSwift


@MainActor
class AuthViewModel: ObservableObject {
    
    
    //MARK: Published Properties
    @Published var isMFAEnabled : Bool = false
    @Published var isPresented : Bool = false
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var flow: AuthenticationFlow = .signin
    
    @Published var isValid: Bool = false
    @Published var authState: AuthenticationState = .unauthenticated
    @Published var errorMsg: String = ""
    @Published var displayName: String = ""
//    @Published var user: User?
    @Published var errorMessage: String?
    @Published var currentUser: User?
    
    //MARK: Private Properties
    private let fbLoginManager = LoginManager()
    private var currentNonce: String?
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    private enum AuthenticationMethod {
        case facebook
        case google
        case apple
        case email
    }
    
    //MARK: Init
    
    init() {
        //TODO: Update isMFAEnable while the VM initializes
        self.isMFAEnabled = isMFAEnabled
        registerAuthStateHandler()
    }
    
    // MARK: Public functions
    /// Sign Out
    ///
    /// This functions signs out the user and catches the error if signout fails.
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Could not sign out: ", error.localizedDescription)
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await currentUser?.delete()
            return true
        } catch {
            print("Could not delete user: ", error.localizedDescription)
            return false
        }
    }
    
    //MARK: Private functions
    /// Register Authenticate State Handler
    ///
    /// This functions checks the changes in Auth States and keeps the users logged in until sign out. It also populates the state display name from Auth displayname for front end display.
    private func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.currentUser = user
                self.authState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? "(unknown)"
            })
        }
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
    
    /// Update/Fetch Display Name
    /// - Parameters:
    ///   - user: User object from which name info is fetched
    ///   - credential: AppleIDCredential for Auth and name fetching
    ///
    ///   This functions fetches the first and last name from AppleIDCredential and assigns the values to Firebase Auth as the user’s display name
    private func updateDisplayName(for user: User, with credential: ASAuthorizationAppleIDCredential, force: Bool = false) async {
        if let currentDisplayName = Auth.auth().currentUser?.displayName, !currentDisplayName.isEmpty {
            print("Current user is non-empty, don’t overwrite it.")
        } else {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = (credential.fullName?.givenName ?? "") + " " + (credential.fullName?.familyName ?? "")
            do {
                try await changeRequest.commitChanges()
                self.displayName = Auth.auth().currentUser?.displayName ?? ""
            } catch {
                print("Could not update the user’s displayname: ", error.localizedDescription)
                errorMessage = error.localizedDescription
            }
        }
    }
}

//MARK: Facebook
extension AuthViewModel {
    
    
    /// SignInWithFaceBook
    ///
    /// This function will:
    /// 1. invoke the login(permissions, viewController) method in of an instance of FBSDKLoginManager
    /// 2. invoke the signIn(with) function in the FireBaseAuth package
    func facebookLogin() {
        authState = .authenticating

        ApplicationDelegate.initializeSDK(nil)
        fbLoginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in //API call for FB-login
          

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
//                                                                           self.navigationController?.popViewController(animated: true)
                                                                            
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
//                            let credential = FacebookAuthProvider.credential(withAccessToken: id)
//                            let result = try await Auth.auth().signIn(with: credential)
////                            print(authState)
                            self.authState = .authenticated
//                            self.currentUser = result.user
//                            print(currentUser)
                            print(self.authState)
                            //TODO: GET USER PROFILE INFO
                        }
                    }
                })
                
                
            }
        }
    }
}

//MARK: Google
extension AuthViewModel {
    
    /// SignInWithGoogle
    ///
    /// This function will:
    /// 1. invoke the signIn(with, presenting) function in GoogleSignIn package with local configuration variables
    /// 2. invoke the signIn(with) function in the FireBaseAuth package
    func handleSignInWithGoogleButton() {
        authState = .authenticating
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { [unowned self] user, error in
            
            if let error = error {
                print(error.localizedDescription)
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
                self.authState = .authenticated
                //TODO: GET USER PROFILE INFO
            }
        }
    }
}

//MARK: Apple
extension AuthViewModel {
    /// SignInWithApple Request Handler
    /// - Parameter request: pass in the request local variable of SignInWithAppleButton onRequest block.
    ///
    /// This function handles Sign in with Apple requests by:
    /// 1. defining the requested scopes of the request - the required information from the user, i.e. full name and/or email
    /// 2. generating a nonce for Firebase Auth and getting the SHA256 hash value of this nonce for Apple Auth Service
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
    }
    /// SignInWithApple Completion Handler
    /// - Parameter result: pass in the result local variable of SignInWithAppleButton onCompletion block.
    ///
    /// This function handles Sign in with Apple completions by:
    /// 1. publishing the error message if the result fails
    /// 2. getting the AppleIDToken and parsing it into a String
    /// 3. generating a Credential object that contains the AppleIDToken and nonce value for Firebase Auth
    /// 4. signing in the user
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        if case .failure(let failure) = result {
            errorMessage = failure.localizedDescription
        } else if case .success(let success) = result {
            if let appleIDCredential = success.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                  print("Unable to fetch identity token")
                  return
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                  print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                  return
                }
                
                let credential = OAuthProvider.credential(
                    withProviderID: "apple.com",
                    idToken: idTokenString,
                    rawNonce: nonce)
                Task {
                    do {
                        let result = try await Auth.auth().signIn(with: credential)
                        print("Signed in with Apple")
                        await updateDisplayName(for: result.user, with: appleIDCredential)
                    } catch {
                        print("Sign in with Apple failed: ", error.localizedDescription)
                    }
                }
            }
        }
    }
}

//MARK: Email
extension AuthViewModel {
    
    /// SignInWithEmail
    /// - Returns: a boolean value that represents if the authentication is successful
    ///
    /// This function will:
    /// 1. update authState in the view model to present the stage of the authentication process
    /// 2. invoke the signIn(withEmail, password) function in the FireBaseAuth package
    func signInWithEmail() async -> Bool {
        authState = .authenticating
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser = authResult.user
            print("Signed in with email and password. User: ", authResult.user.uid)
            return true
        } catch {
            print("Could not sign in with email and password provided: ", error.localizedDescription)
            errorMsg = error.localizedDescription
            authState = .unauthenticated
            return false
        }
    }
    
    /// SignUpWithEmail
    /// - Returns: a boolean value that represents if the authentication is successful
    ///
    /// This function will:
    /// 1. update authState in the view model to present the stage of the authentication process
    /// 2. invoke the signUp(withEmail, password) function in the FireBaseAuth package
    func signUpWithEmail() async -> Bool {
        print("auth")
        authState = .authenticating
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUser = authResult.user
            print("User signed up. Signed in with email and password. User: ", authResult.user.uid)
            return true
        } catch {
            print("Could not sign up with email and password provided: ", error.localizedDescription)
            errorMsg = error.localizedDescription
            authState = .unauthenticated
            return false
        }
    }
}

//MARK: Security Layer - Nonce & SHA256
extension AuthViewModel {
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

}
