//
//  Dashboard.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-13.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var authVM : AuthViewModel
    
    var user: NewEndUser
    var body: some View {
        NavigationView {
            VStack{
                Text("Welcome to Dashboard!")
                
                Button {
                    authVM.signOut()
                } label: {
                    Text("Sign Out")
                }

            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    UserProfileIconView(user: authVM.currentEndUser ?? user)
                }
            }
        }
        
    }
}

struct Dashboard_Previews: PreviewProvider {
    static let user: NewEndUser = NewEndUser(
        id: userIDMichaelLogan,
        name: "Michael Logan",
        profileImage: "User Profile Image",
        age: 23,
        phone: "437-123-1234",
        email: "mlogan2000@icloud.com",
        preferredTrainerGender: .m,
        gymLocation: "Etobicoke, ON",
        preferredGym: .fitForLess,
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
        Dashboard(user: user)
            .environmentObject(AuthViewModel())
    }
}
