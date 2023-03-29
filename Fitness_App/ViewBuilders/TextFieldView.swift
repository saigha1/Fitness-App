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
//    var name : String = "Hello"
    var cornerRadius: CGFloat = 6
    var strokeColor: Color = .black
    var strokeWidth: CGFloat = 1
    var offsetX: CGFloat = -10
    var offsetY: CGFloat = 0
    var width: CGFloat = 310
    var height: CGFloat = 30
    var isLong: Bool = false
    
    var body: some View{
        Group {
            if isLong{
                TextEditor(text: textInput)
            } else {
                Group{
                    if !isPassword{
                        TextField(
                            placeholder, text: textInput
                        )
                    } else {
                        SecureField(
                            placeholder,
                            text: textInput
                        )
                    }
                }
            }
        }
        .offset(x: -offsetX, y: offsetY)
        .frame(width: width, height: height)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(strokeColor, lineWidth: strokeWidth)
               
        )
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFieldView(textInput: .constant("user"), placeholder: "", isPassword: false)
            TextFieldView(textInput: .constant("password"), placeholder: "", isPassword: true)
            TextFieldView(textInput: .constant(""), placeholder: "Placeholder",  isPassword: false, cornerRadius: 5, strokeColor: .red, strokeWidth: 2, offsetX: -15, offsetY: 0, width: 210, height: 30)
            TextFieldView(textInput: .constant(""), placeholder: "Placeholder", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 2, offsetX: -15, offsetY: 0, width: UIScreen.main.bounds.width * 0.8, height: 120, isLong: true)
        }
    }
}
