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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate     //Firebase recommends adding var delegate instead of var appDelegate
        
    @StateObject var googleFireBaseVM = GoogleSignInWithFirebase()
    @StateObject var facebookFirebaseSignIn = UserLoginManager()
    
    var body: some Scene {
        WindowGroup {
            LoginPage()
                .environmentObject(googleFireBaseVM)
                .environmentObject(facebookFirebaseSignIn)
            
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
