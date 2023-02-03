//
//  FireBaseSignInWithAppleViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 2/2/23.
//

import Foundation
import AuthenticationServices
import CryptoKit
import Firebase

class FireBaseSignInWithAppleViewModel: ObservableObject {
    private var currentNonce: String?
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    @Published var errorMessage: String?
    @Published var displayName: String?
    @Published var currentUser: User?
    @Published var authState: AuthenticationState = .unauthenticated
    
    init() {
        registerAuthStateHandler()
    }
    
    //MARK: PART 1 - Sign in with Apple Button Handler
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
    
    //MARK: PART 2 - Uppdate Display Name
    /// Update/Fetch Display Name
    /// - Parameters:
    ///   - user: User object from which name info is fetched
    ///   - credential: AppleIDCredential for Auth and name fetching
    ///
    ///   This functions fetches the first and last name from AppleIDCredential and assigns the values to Firebase Auth as the user’s display name
    func updateDisplayName(for user: User, with credential: ASAuthorizationAppleIDCredential, force: Bool = false) async {
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
    
    //MARK: PART 3 - Auth State
    /// Register Authenticate State Handler
    ///
    /// This functions checks the changes in Auth States and keeps the users logged in until sign out. It also populates the state display name from Auth displayname for front end display.
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.currentUser = user
                self.authState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.displayName ?? user?.email ?? ""
            })
        }
    }
    
    //MARK: PART 4 - Sign Out
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
}

extension FireBaseSignInWithAppleViewModel {
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
