//
//  NewFile.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-01.
//


// AppDelegate.swift
import UIKit
import FacebookCore
import FacebookLogin
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

import GoogleSignIn

class AppDelegate: UIResponder, UIApplicationDelegate {

    
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    
    FirebaseApp.configure()     //To configure Firebase
    return true
}
    //Google Sign-in using Firebase
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    ///For Scene Delegate Calling
    func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
    sceneConfig.delegateClass = FSSceneDelegate.self // 👈🏻
    return sceneConfig
  }
    
    //For FB-Login
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
    }
    
   
}


