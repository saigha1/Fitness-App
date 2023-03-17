//
//  Dashboard.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-13.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var authVM : AuthViewModel
    @State var isPTProfileComplete : Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                if !isPTProfileComplete{
                    Text("Please complete your profile!")
                } else {
                    DashboardContent
                }
                
                Button {
                    authVM.signOut()
                } label: {
                    Text("Sign Out")
                }

            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                !authVM.isEnderUser ? UserProfileIconView() : UserProfileIconView()
                    
                }
            }
        }
        
    }
    
    var DashboardContent: some View{
        VStack{
            Text("...Loading profile info")
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
        Dashboard()
            .environmentObject(AuthViewModel())
    }
}
