//
//  SceneDelegate.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-01.
//

import Foundation
import FacebookCore

// SceneDelegate.swift
class FSSceneDelegate: NSObject, UIWindowSceneDelegate {
//  func sceneWillEnterForeground(_ scene: UIScene) {
//    // ...
//  }
//
//  func sceneDidBecomeActive(_ scene: UIScene) {
//    // ...
//  }
//
//  func sceneWillResignActive(_ scene: UIScene) {
//    // ...
//  }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }


}
