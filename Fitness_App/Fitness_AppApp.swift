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
        
//    @StateObject var googleFireBaseVM = GoogleSignInWithFirebase()
//    @StateObject var facebookFirebaseSignIn = UserLoginManager()
//    @StateObject private var authVMEmail: FireBaseSignInWithEmailViewModel
    
    /// Declare the authentication view model instance to be used as an environment object for signin & signup views
    @StateObject private var authenticationVM = AuthViewModel()
//    @StateObject private var modelData = ModelData()
    
    
//    init() {
//        self._authenticationVM = StateObject(wrappedValue: .init())
//    }
    
    var body: some Scene {
        WindowGroup {
//            Sign_Up_View()
//                .environmentObject(modelData)
            
            Sign_Up_View(PT: PTModelPreview)
//                .environmentObject(googleFireBaseVM)
//                .environmentObject(facebookFirebaseSignIn)
                .environmentObject(authenticationVM)
            
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

let PTModelPreview = PTModel(id: "hello", name: "hello", gender: "hello", phone: "hello", email: "hello", isFeatured: true, isFavorite: true, education: .Other, certification: [.Other], selectedExperience: .One, cityLocation: .Mississauga, workoutTypes: [.calisthenic], gymPreference: [.GoodLife], description: "hello", motto: "hello", profileImg: "hello")
