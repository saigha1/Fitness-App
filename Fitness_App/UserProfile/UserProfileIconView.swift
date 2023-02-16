//
//  UserProfileIconView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI

let userProfileImage = Image("User Profile Image")

struct UserProfileIconView: View {
    @State private var shouldShowProfileSheet: Bool = false
    var body: some View {
        userProfileImage
            .resizable()
            .scaledToFit()
            .frame(width: 45, height: 45, alignment: .center)
            .cornerRadius(25)
            .clipShape(Circle(), style: .init(eoFill: true, antialiased: true))
            .shadow(color: .primary.opacity(0.5), radius: 10, x: 3, y: 3)
            .onTapGesture {
                shouldShowProfileSheet.toggle()
            }
            .sheet(isPresented: $shouldShowProfileSheet, content: {
                if #available(iOS 16.0, *) {
                    UserProfileView()
                        .presentationDetents([.large])
                } else {
                    // Fallback on earlier versions
                    UserProfileView()
                }
            })
    }
}

struct UserProfileIconView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileIconView()
    }
}
