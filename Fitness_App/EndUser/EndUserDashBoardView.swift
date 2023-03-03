//
//  EndUserDashBoardView.swift
//  Fitness_App
//
//  Created by Xavier on 2/27/23.
//

import SwiftUI

struct EndUserDashBoardView: View {
    @EnvironmentObject var authVM : AuthViewModel
    
    init(user: NewEndUser? = nil) {
        guard user != nil else {
            self.user = NewEndUser(
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
            return
        }
        self.user = user
    }
    
    var user: NewEndUser? = nil
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                content
            }
        }
    }
}

struct EndUserDashBoardView_Previews: PreviewProvider {
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
        EndUserDashBoardView(user: user)
            .environmentObject(AuthViewModel())
    }
}

extension EndUserDashBoardView {
    private var content: some View {
        VStack {
            Button {
                authVM.signOut()
            } label: {
                Text("Sign Out")
            }
            Text("Dashboard contents goes here")
        }
        .navigationTitle("Dashboard")
        .toolbar {
            ToolbarItem {
                UserProfileIconView(user: authVM.currentEndUser ?? user!)
            }
        }
    }
}
