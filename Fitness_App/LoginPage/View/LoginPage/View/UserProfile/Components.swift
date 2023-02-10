//
//  Header.swift
//  Fitness_App
//
//  Created by Xavier on 2/9/23.
//

import SwiftUI
import Charts

//MARK: Header
extension UserProfileView {
    var header: some View {
        Group {
            //Dismiss Button
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
            
            //User’s Profile Image & Name
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
        }
    }
}

//MARK: Personal Info Section
extension UserProfileView {
    var personalInfo: some View {
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
}

//MARK: Preferences Section
extension UserProfileView {
    var preferences: some View {
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
}

//MARK: Health Metrics Section
extension UserProfileView {
    var healthMetrics: some View {
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

//MARK: Workout Journey Section

extension UserProfileView {
    var workoutJouney: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                //Title
                HStack {
                    userProfileIcon_Journey
                    Text("Workout Journey")
                        .bold()
                }
                .foregroundColor(.indigo)
                
                Divider()
                
                //Chart
                if #available(iOS 16.0, *) {
                    Chart {
                        ForEach(sortedKeys, id: \.self) { key in
                            BarMark(x: .value("Month", key.asStringYYYYMM()), y: .value("# of workout", groupedAppoints[key]?.count ?? 0))
                                .foregroundStyle(.indigo.opacity(0.7))
                            LineMark(x: .value("Month", key.asStringYYYYMM()), y: .value("# of workout", groupedAppoints[key]?.count ?? 0))
                                .foregroundStyle(.indigo)

                        }
                    }
                } else {
                    //Fallback on earlier versions
                    HStack(alignment: .bottom) {
                        ForEach(sortedKeys, id: \.self) { key in
                            VStack {
                                Spacer()
                                Text("\(groupedAppoints[key]?.count ?? 0)")
                                    .offset(x: 0, y: 10)
                                Rectangle()
                                    .fill(Color.indigo)
                                    .frame(
                                        width: CGFloat(UIScreen.main.bounds.width/CGFloat(sortedKeys.count)/3 * 2),
                                        height: CGFloat(groupedAppoints[key]?.count ?? 0) * 15)
                                Text(key.asString("MMM-yy"))
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    .frame(height: 20)
                            }
                        }
                    }
                }
                
                //Chart Description
                Text("Workout appointments attended by month")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.secondary)
            }
        }
    }
}
