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
                Group {
                    if endUserProfileVM.selectedImages.isEmpty {
                        authVM.currentEndUser!.profileImage.asProfileImage(100)
                    } else {
                        Image(uiImage: endUserProfileVM.selectedImages.first!)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    }
                }
                .onTapGesture {
                    if isEditing {
                        showImagePicker.toggle()
                    }
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $endUserProfileVM.selectedImages, selectionLimit: 1)
                        .onChange(of: endUserProfileVM.selectedImages) { _ in
                            //endUserProfileVM.updateProfileImage()
                            print("")
                        }
                }
                Text(authVM.currentEndUser!.name)
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
            
            //Age
            HStack {
                Text("Age")
                    .bold()
                Spacer()
                Text("\(authVM.currentEndUser!.age)")
            }
            
            //Phone Number
            HStack {
                Text("Phone Number")
                    .bold()
                Spacer()
                Group {
                    if isEditing {
                        TextFieldView(textInput: $endUserProfileVM.phoneNumber, placeholder: authVM.currentEndUser!.phone, isPassword: false, cornerRadius: 0, strokeColor: .clear, strokeWidth: 0, offsetX: 0, offsetY: 0, width: 200, height: 8)
                            .keyboardType(.phonePad)
                    } else {
                        Text(authVM.currentEndUser!.phone)
                    }
                }
            }
            
            //Email
            HStack {
                Text("Email")
                    .bold()
                Spacer()
                Group {
                    if isEditing {
                        TextFieldView(textInput: $endUserProfileVM.email, placeholder: authVM.currentEndUser!.email, isPassword: false, cornerRadius: 0, strokeColor: .clear, strokeWidth: 0, offsetX: 0, offsetY: 0, width: 200, height: 8)
                            .keyboardType(.emailAddress)
                    } else {
                        Text(authVM.currentEndUser!.email)
                    }
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
            
            //Preferred trainer gender
            HStack {
                Text("Trainer Gender")
                    .bold()
                Spacer()
                Group {
                    if isEditing {
                        Picker("Gender", selection: $endUserProfileVM.selectedPTGender) {
                            ForEach(TrainerGender.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    } else {
                        Text(authVM.currentEndUser!.preferredTrainerGender.rawValue)
                    }
                }
            }
            
            //Gym Location
            HStack {
                Text("Gym Location")
                    .bold()
                Spacer()
                Group {
                    if isEditing {
                        TextFieldView(textInput: $endUserProfileVM.gymLoocation, placeholder: authVM.currentEndUser!.gymLocation, isPassword: false, cornerRadius: 0, strokeColor: .clear, strokeWidth: 0, offsetX: 0, offsetY: 0, width: 200, height: 8)
                    } else {
                        Text(authVM.currentEndUser!.gymLocation)
                    }
                }
            }
            
            //Preferred gym
            HStack {
                Text("Preferred Gym")
                    .bold()
                Spacer()
                Group {
                    if isEditing {
                        Picker("Preferred Gym", selection: $endUserProfileVM.preferredGym) {
                            ForEach(PreferredGym.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    } else {
                        Text(authVM.currentEndUser!.preferredGym.rawValue)
                    }
                }
            }
            
            
            //Workout Types
            Group {
                HStack {
                    Text("Workout Type 1")
                        .bold()
                    Spacer()
                    Group {
                        if isEditing {
                            Picker("Workout Type 1", selection: $endUserProfileVM.typesOfWorkout[0]) {
                                ForEach(WorkOutType.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                        } else {
                            Text(authVM.currentEndUser!.typesOfWorkOut[0].rawValue)
                        }
                    }
                }
                HStack {
                    Text("Workout Type 2")
                        .bold()
                    Spacer()
                    Group {
                        if isEditing {
                            Picker("Workout Type 2", selection: $endUserProfileVM.typesOfWorkout[1]) {
                                ForEach(WorkOutType.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                        } else {
                            Text(authVM.currentEndUser!.typesOfWorkOut[1].rawValue)
                        }
                    }
                }
                HStack {
                    Text("Workout Type 3")
                        .bold()
                    Spacer()
                    Group {
                        if isEditing {
                            Picker("Workout Type 3", selection: $endUserProfileVM.typesOfWorkout[2]) {
                                ForEach(WorkOutType.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                        } else {
                            Text(authVM.currentEndUser!.typesOfWorkOut[2].rawValue)
                        }
                    }
                }
            }
            
            //Price Range
            HStack {
                Text("Price Range")
                    .bold()
                Spacer()
                Group {
                    if isEditing {
                        TextFieldView(textInput: $endUserProfileVM.priceRangeLow, placeholder: "low", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 120, height: 25)
                            .keyboardType(.decimalPad)
                        TextFieldView(textInput: $endUserProfileVM.priceRangeHigh, placeholder: "high", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 120, height: 25)
                            .keyboardType(.decimalPad)
                    } else {
                        Text("\(authVM.currentEndUser!.preferredPriceRange.min.formatted(.currency(code: authVM.currentEndUser!.preferredPriceRange.currency.rawValue))) ~ \(authVM.currentEndUser!.preferredPriceRange.max.formatted(.currency(code: authVM.currentEndUser!.preferredPriceRange.currency.rawValue)))")
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
            //Height
            HStack {
                Text("Height")
                    .bold()
                Spacer()
                if isEditing {
                    Group {
                        TextFieldView(textInput: $endUserProfileVM.heightFt, placeholder: "\(authVM.currentEndUser!.heightFt)", isPassword: false, cornerRadius: 0, strokeColor: .clear, strokeWidth: 0, offsetX: 0, offsetY: 0, width: 30, height: 8)
                            .keyboardType(.numberPad)
                        Text("'").offset(x: -15)
                        TextFieldView(textInput: $endUserProfileVM.heightIn, placeholder: "\(authVM.currentEndUser!.heightIn.asStringWith2Decimals())", isPassword: false, cornerRadius: 0, strokeColor: .clear, strokeWidth: 0, offsetX: 0, offsetY: 0, width: 70, height: 8)
                            .keyboardType(.decimalPad)
                        Text("''").offset(x: -15)
                    }
                } else {
                    Text("\(authVM.currentEndUser!.heightFt)' \(authVM.currentEndUser!.heightIn.asStringWith2Decimals())''")
                }
            }
            //Skeletal Muscle Mass
            HStack {
                Text("Skeletal Muscle Mass")
                    .bold()
                Spacer()
                if isEditing {
                    TextFieldView(textInput: $endUserProfileVM.skeletalMuscleMass, placeholder: "\(authVM.currentEndUser!.skeletalMuscleMass.asStringWith2Decimals())", isPassword: false, cornerRadius: 0, strokeColor: .clear, strokeWidth: 0, offsetX: 0, offsetY: 0, width: 70, height: 8)
                        .keyboardType(.decimalPad)
                } else {
                    Text(authVM.currentEndUser!.skeletalMuscleMass.asStringWith2Decimals())
                }
            }
            Group {
                HStack {
                    Spacer()
                    Text("Current")
                    Text("Target")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.trailing, 20)
                //Weight
                HStack {
                    Text("Weight (lbs)")
                        .bold()
                    Spacer()
                    if isEditing {
                        TextFieldView(textInput: $endUserProfileVM.currentWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                            .keyboardType(.decimalPad)
                        TextFieldView(textInput: $endUserProfileVM.targetWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                            .keyboardType(.decimalPad)
                    } else {
                        Text(authVM.currentEndUser!.currentWeight.asStringWith2Decimals())
                        Text(authVM.currentEndUser!.targetWeight.asStringWith2Decimals())
                    }
                }
                //Fat
                HStack {
                    Text("Body Fat (%)")
                        .bold()
                    Spacer()
                    if isEditing {
                        TextFieldView(textInput: $endUserProfileVM.currentFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                            .keyboardType(.decimalPad)
                        TextFieldView(textInput: $endUserProfileVM.targetFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                            .keyboardType(.decimalPad)
                    } else {
                        Text("\(authVM.currentEndUser!.currentBodyFat.asStringWith2Decimals())%")
                        Text("\(authVM.currentEndUser!.targetBodyFat.asStringWith2Decimals())%")
                    }
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
