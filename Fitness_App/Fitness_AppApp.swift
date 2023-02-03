//
//  Fitness_AppApp.swift
//  Fitness_App
//
//  Created by MAC on 2022-12-22.
//

import SwiftUI
import GoogleSignIn


@main
struct Fitness_AppApp: App {
    /// AppDelegateAdapter that registers the app delegate for firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate     //Firebase recommends adding var delegate instead of var appDelegate
        
    @StateObject var googleFireBaseVM = GoogleSignInWithFirebase()
    @StateObject var facebookFirebaseSignIn = UserLoginManager()
    /// Declare the authentication view model instance to be used as an environment object for signin & signup views
    @StateObject private var authVMEmail: FireBaseSignInWithEmailViewModel
    
    init() {
        self._authVMEmail = StateObject(wrappedValue: .init())
    }
    
    var body: some Scene {
        WindowGroup {
            LoginPage()
                .environmentObject(googleFireBaseVM)
                .environmentObject(facebookFirebaseSignIn)
                .environmentObject(authVMEmail)
            
            .onOpenURL { url in
                      GIDSignIn.sharedInstance.handle(url)
            }
            
            .onAppear {
                GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                    // Check if `user` exists; otherwise, do something with `error`
                }
            }
        }
    }
}
