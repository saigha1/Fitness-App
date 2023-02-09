//
//  UserProfileView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI
import Charts


var appointsOfCurrentUser: [WorkOutAppointment] {
    appointments.filter { appointment in
        appointment.userID == userIDMichaelLogan
    }
}
let groupedAppoints = appointsOfCurrentUser.sliced(by: [.year, .month], for: \.date)
let sortedKeys = Array(groupedAppoints.keys).sorted(by: <)

struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    sharedIcon_CancelOrDislike
                        .font(.system(size: 30))
                        .padding(.trailing, 30)
                }
            }
            .padding(.top, 50)
            HStack {
                user.profileImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45, alignment: .center)
                    .cornerRadius(15)
                    .padding(.leading, 70)
                Spacer()
                Text(user.name)
                    .font(.title2)
                    .bold()
                    .padding(.trailing, 70)
            }
            
            VStack(alignment: .leading, spacing: 15) {
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
            working()
        }
    }
}

extension UserProfileView {
    
    private func working() {
        print("Fetching data...")
        
    }
    
    private var workoutJouney: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    userProfileIcon_Journey
                    Text("Workout Journey")
                        .bold()
                }
                .foregroundColor(.indigo)
                
                if #available(iOS 16.0, *) {
                    Chart {
                        
                        ForEach(sortedKeys, id: \.self) { key in
                            BarMark(x: .value("Month", key.asStringYYYYMM()), y: .value("# of workout", groupedAppoints[key]?.count ?? 0))
                                .foregroundStyle(.indigo.opacity(0.8))
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

extension UserProfileView {
    private var personalInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                userProfileIcon_Person
                Text("Personal Info")
                    .bold()
            }
            .foregroundColor(Color.assetColor.purple)
            Divider()
            
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Age")
                        .bold()
                    Text("Phone Number")
                        .bold()
                    Text("Email")
                        .bold()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(user.age)")
                    Text(user.phoneNum)
                    Text(user.email)
                }
            }
        }
    }
    private var preferences: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                userProfileIcon_Preference
                Text("Preferences")
                    .bold()
            }
            .foregroundColor(Color.assetColor.blue)
            Divider()
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Trainer Gender")
                        .bold()
                    Text("Gym Location")
                        .bold()
                    Text("Types of Workout")
                        .bold()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(user.preferredPTGender)")
                    Text("\(user.gymLocation)")
                    VStack(alignment: .trailing) {
                        ForEach(user.typesOfWorkout, id: \.self) {type in
                            Text(type)
                        }
                    }
                }
            }
        }
    }
    private var healthMetrics: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                userProfileIcon_Health
                Text("Health Metrics")
                    .bold()
            }
            .foregroundColor(Color.assetColor.pink)
            .foregroundColor(.green)
            Divider()
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Height")
                        .bold()
                    Text("Skeletal Muscle Mass")
                        .bold()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(user.heightFt)'\(user.heightIn.asStringWith2Decimals())" + "\"")
                    Text("\(user.skeletalMuscleMass.asStringWith2Decimals()) lbs.")
                }
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Weight(lbs)")
                        .bold()
                    Text("Body Fat Percentage")
                        .bold()
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Current")
                        .foregroundColor(.secondary)
                    Text(user.currentWeight.asStringWith2Decimals())
                    Text(user.currentBodyFat.asPercentageStringWith2Decimals())
                }
                
                VStack(alignment: .trailing) {
                    Text("Target")
                        .foregroundColor(.secondary)
                    Text(user.targetWeight.asStringWith2Decimals())
                    Text(user.targetBodyFat.asPercentageStringWith2Decimals())
                }
            }
        }
    }
}
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

struct EndUser {
    var id: UUID
    //personal info
    var name: String
    var profileImage: Image
    var age: Int
    var phoneNum: String
    var email: String
    //preferences
    var preferredPTGender: String
    var gymLocation: String
    var typesOfWorkout: [String]
    var preferredPriceRange: PriceRangePrefrence
    //health metrics
    var heightFt: Int
    var heightIn: Double
    var skeletalMuscleMass: Double
    var currentWeight: Double
    var targetWeight: Double
    var currentBodyFat: Double
    var targetBodyFat: Double
}

struct PriceRangePrefrence {
    var currencyCode: String
    var min: Double
    var max: Double
}

let userIDMichaelLogan = UUID(uuidString: "a7a3c754-e154-4e15-bbab-2cbc03d2fe19") ?? UUID()
let user = EndUser(
    id: userIDMichaelLogan,
    name: "Michael Logan",
    profileImage: userProfileImage,
    age: 23,
    phoneNum: "437-123-1234",
    email: "mlogan2000@icloud.com",
    preferredPTGender: "Male",
    gymLocation: "Etobicoke, ON",
    typesOfWorkout: [
        "Machine-based",
        "Weight-Lifting",
        "Boxing"
    ],
    preferredPriceRange: PriceRangePrefrence(
        currencyCode: "CAD",
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

struct WorkOutAppointment {
    var appointmentID: UUID
    var userID: UUID
    var trainerID: UUID
    var date: Date
    var isCompleted: Bool
}

let appointments: [WorkOutAppointment] = [
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: Date(),
        isCompleted: false),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230120".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230114".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230111".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230107".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230103".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221222".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221221".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221220".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221202".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221122".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221120".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221020".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20220918".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20220917".yyyyMMddToDate(),
        isCompleted: true)
]
