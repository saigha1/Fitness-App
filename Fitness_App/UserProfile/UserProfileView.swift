//
//  UserProfileView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss
    //State private properties for editing mode
    @State var isEditing: Bool = false
    @State var phoneNumber: String = ""
    @State var email: String = ""
    @State var gymLoocation: String = ""
    @State var typesOfWorkout: [String] = []
    // Temp properties for pickers
    @State var selectedPTGender: String = ""
    
    var user: EndUser
    
    var body: some View {
        ScrollView {
            header
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Spacer()
                    Button {
                        isEditing = isEditing ? false : true
                    } label: {
                        Text(isEditing ? "Done" : "Edit")
                            .foregroundColor(.accentColor)
                    }
                    .sheet(isPresented: $isEditing) {
                        UserSignUpFormView()
                    }
                }
                personalInfo
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.white)
                    )
                preferences
                healthMetrics
                workoutJouney
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.secondary.opacity(0.2))
                    .padding(.horizontal, 7)
            )
            Spacer()
        }
        .onAppear {
            self.phoneNumber = user.phone
            self.email = user.email
            self.gymLoocation = user.gymLocation
            self.typesOfWorkout = user.typesOfWorkOut
            self.selectedPTGender = user.preferredTrainerGender
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
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
        UserProfileView(user: user)
    }
}


var appointsOfCurrentUser: [WorkOutAppointment] {
    appointments.filter { appointment in
        appointment.userID == userIDMichaelLogan
    }
}
let groupedAppoints = appointsOfCurrentUser.sliced(by: [.year, .month], for: \.date)
let sortedKeys = Array(groupedAppoints.keys).sorted(by: <)
