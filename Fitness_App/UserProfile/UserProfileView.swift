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
    @State var phoneNumber: String = user.phone
    @State var email: String = user.email
    @State var gymLoocation: String = user.gymLocation
    @State var typesOfWorkout: [String] = user.typesOfWorkOut
//    @State var heightFeet: Int = user.heightFt
//    @State var heightInch: Double = user.heightIn
//    @State var skeletalMuscleMass: Double = user.skeletalMuscleMass
//    @State var currentWeight: Double = user.currentWeight
//    @State var currentBodyFat: Double = user.currentBodyFat
//    @State var targetWeight: Double = user.targetWeight
//    @State var targetBodyFat: Double = user.targetBodyFat
    
    // Temp properties for pickers
    @State var selectedPTGender: String = user.preferredTrainerGender
    
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
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}


var appointsOfCurrentUser: [WorkOutAppointment] {
    appointments.filter { appointment in
        appointment.userID == userIDMichaelLogan
    }
}
let groupedAppoints = appointsOfCurrentUser.sliced(by: [.year, .month], for: \.date)
let sortedKeys = Array(groupedAppoints.keys).sorted(by: <)
