//
//  FireBaseSignInWithEmailViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 2/2/23.
//

import Foundation
import FirebaseAuth

@MainActor
class FireBaseSignInWithEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var flow: AuthenticationFlow = .signin
    
    @Published var isValid: Bool = false
    @Published var authState: AuthenticationState = .unauthenticated
    @Published var errorMsg: String = ""
    @Published var displayName: String = ""
    @Published var user: User?
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    private func registerAuthStateHandler() {
        if authStateHandle == nil {
            authStateHandle = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? "(unknown)"
            })
        }
    }
    
    init() {
        registerAuthStateHandler()
    }
}

//MARK: Sign in with Email & Password
extension FireBaseSignInWithEmailViewModel {
    func signInWithEmail() async -> Bool {
        authState = .authenticating
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            print("Signed in with email and password. User: ", authResult.user.uid)
            return true
        } catch {
            print("Could not sign in with email and password provided: ", error.localizedDescription)
            errorMsg = error.localizedDescription
            authState = .unauthenticated
            return false
        }
    }
    func signUpWithEmail() async -> Bool {
        print("auth")
        authState = .authenticating
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            print("User signed up. Signed in with email and password. User: ", authResult.user.uid)
            return true
        } catch {
            print("Could not sign up with email and password provided: ", error.localizedDescription)
            errorMsg = error.localizedDescription
            authState = .unauthenticated
            return false
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Could not sign out: ", error.localizedDescription)
        }
    }
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        } catch {
            print("Could not delete user: ", error.localizedDescription)
            return false
        }
    }
}
