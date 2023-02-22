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
    var user: EndUser
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
                    UserProfileView(user: user)
                        .presentationDetents([.large])
                } else {
                    // Fallback on earlier versions
                    UserProfileView(user: user)
                }
            })
    }
}

struct UserProfileIconView_Previews: PreviewProvider {
    static let user: EndUser = EndUser(
        id: userIDMichaelLogan,
        name: "Michael Logan",
        profileImageName: "User Profile Image",
        age: 23,
        phone: "437-123-1234",
        email: "mlogan2000@icloud.com",
        preferredTrainerGender: "Male",
        gymLocation: "Etobicoke, ON",
        typesOfWorkOut: [
            "Machine-based",
            "Weight-Lifting",
            "Boxing"
        ],
        preferredPriceRange: PriceRangePrefrence(
            currency: "CAD",
            min: 400,
            max: 700),
        heightFt: 5,
        heightIn: 10,
        skeletalMuscleMass: 83.3,
        currentWeight: 177,
        targetWeight: 157,
        currentBodyFat: 0.22,
        targetBodyFat: 0.18
    )
    static var previews: some View {
        UserProfileIconView(user: user)
    }
}
