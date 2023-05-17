//
//  PaymentConfirmationAlert.swift
//  Fitness_App
//
//  Created by Xavier on 5/17/23.
//

import SwiftUI

struct PaymentConfirmationAlert<Content: View>: View {
    let buttons: Content
    let width: CGFloat
    let height: CGFloat
    let spacerHeight: CGFloat
    
    init(@ViewBuilder buttons: () -> Content, width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.height * 0.35, spacerHeight: CGFloat = UIScreen.main.bounds.height * 0.2 * 0.05) {
        self.buttons = buttons()
        self.width = width
        self.height = height
        self.spacerHeight = spacerHeight
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.assetColor.blue, .assetColor.white, .assetColor.white], startPoint: .top, endPoint: .bottom)
                .frame(width: width, height: height, alignment: .center)
                .cornerRadius(15)
                .shadow(color: .assetColor.blue, radius: 5)
            VStack {
                VStack {
                    Text("Payment Successful!")
                        .foregroundColor(.white)
                        .bold()
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)

                        .foregroundColor(.green)
                }
                .font(.title2)
                .padding(.vertical, 40)

                Spacer()
                    .frame(height: spacerHeight)
                buttons
                    .padding(.vertical, 30)
            }.padding()
        }
    }
}

struct PaymentConfirmationAlert_Previews: PreviewProvider {
    static var previewButton: some View {
        VStack {
            Button {
                //
            } label: {
                Text("Continue Browsing")
            }
        }

    }
    static var previews: some View {
        PaymentConfirmationAlert {
            previewButton
        }
    }
}
