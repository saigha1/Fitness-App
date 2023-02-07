//
//  ButtonLabelWithIconView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI

struct ButtonLabelWithIconView: View {
    var isSystemImage: Bool = true
    var icon: Image = Image(systemName: "apple.logo")
    var spacerWidth: CGFloat = 20
    var text: String = "Sign in with Apple"
    var horizontalPadding: CGFloat = 10
    var fgColor: Color = .white
    var bgColor: Color = .black
    var width: CGFloat = 250
    var height: CGFloat = 60
    var cornerRadius: CGFloat = 6
    var strokeWidth: CGFloat = 1
    
    var body: some View {
        HStack {
            if isSystemImage {
                icon
            } else {
                icon.resizable().scaledToFit().padding(.vertical)
            }
            Spacer().frame(width: spacerWidth)
            Text(text)
                .bold()
        }
        .padding(.horizontal, horizontalPadding)
        .foregroundColor(fgColor)
        .frame(width: width, height: height, alignment: .center)
        .background(bgColor)
        .overlay(
            Rectangle()
                .stroke(fgColor.opacity(0.5), lineWidth: strokeWidth)
                .frame(width: width, height: height, alignment: .center)
        )
    }
}

struct ButtonLabelView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ButtonLabelWithIconView()
            ButtonLabelWithIconView(icon: tabIcon_Dashboard, text: "back to Dashboard", bgColor: Color.assetColor.pink, width: 240, height: 40)
            ButtonLabelWithIconView(
                isSystemImage: false,
                icon: Image("Facebook-logo"),
                text: "Sign in with Facebook",
                bgColor: Color(red: 3/255, green: 115/255, blue: 230/255))
            ButtonLabelWithIconView(
                isSystemImage: false,
                icon: Image("google-logo"),
                text: "Sign in with Google",
                fgColor: .primary,
                bgColor: Color.white)
            ButtonLabelWithIconView(
                isSystemImage: true,
                icon: Image(systemName: "envelope"),
                text: "Sign in with Email",
                fgColor: .white,
                bgColor: Color.assetColor.purple)
        }
    }
}
