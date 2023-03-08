//
//  UserProfileIconView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI


struct UserProfileIconView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var shouldShowProfileSheet: Bool = false
    
    var body: some View {
        authVM.currentEndUser!.profileImage.asProfileImage(45)
            .onTapGesture {
                shouldShowProfileSheet.toggle()
            }
            .sheet(isPresented: $shouldShowProfileSheet, content: {
                if #available(iOS 16.0, *) {
                    UserProfileView(user: authVM.currentEndUser!)
                        .environmentObject(authVM)
                        .presentationDetents([.large])
                } else {
                    // Fallback on earlier versions
                    UserProfileView(user: authVM.currentEndUser!)
                        .environmentObject(authVM)
                }
            })
    }
}

struct UserProfileIconView_Previews: PreviewProvider {
    static let authVM = AuthViewModel()
    static let user: NewEndUser = NewEndUser(
        id: userIDMichaelLogan,
        name: "Michael Logan",
        profileImage: "User Profile Image",
        age: 23,
        phone: "437-123-1234",
        email: "mlogan2000@icloud.com",
        preferredTrainerGender: .m,
        gymLocation: "Etobicoke, ON",
        preferredGym: .anytime,
        typesOfWorkOut: [.boxing, .lifting],
        preferredPriceRange: PriceRange(
            currency: .cad,
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
        if authVM.currentEndUser != nil {
            UserProfileView(user: user)
                .environmentObject(authVM)
        }
    }
}
