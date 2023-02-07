//
//  FacebookLogin.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-06.
//

import SwiftUI
import FacebookLogin


struct facebookLogin: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        FBLoginButton()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
   
}
