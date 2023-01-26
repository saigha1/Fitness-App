//
//  TextFieldView.swift
//  Fitness_App
//
//  Created by MAC on 2023-01-25.
//

import SwiftUI

struct TextFieldView: View{
    @State var textInput : Binding<String>
    let placeholder: String
    let isPassword: Bool
    var body: some View{
        Group {
            if !isPassword{
                TextField(
                    placeholder, text: textInput
                )
                
                
            } else{
                SecureField(
                    placeholder,
                    text: textInput
                )
            }
        }
        
        .font(Font.title2.weight(.bold))
        .frame(width: 300, height: 30)
        .textFieldStyle(.roundedBorder)
        .border(.black, width: 1)
        .padding()
        
        
        
        
    }
}
