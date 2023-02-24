//
//  UserSignUpFormView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI

//let genders = ["Male", "Female"]
//let workoutTypes = ["Machine-based", "Boxing", "Weight-lifting", "Calisthenics"]

struct UserSignUpFormView: View {    
    @StateObject private var vm = UserSignUpFormViewModel()
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 10) {
                        personalInfoSection
                        preferenceSection
                        metricsSection
                    }
                    if !vm.error.isEmpty {
                        Text(vm.error)
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                Button {
                    vm.validateForm()
                } label: {
                    Text("Continue")
                        .bold()
                        .font(.title2)
                }

            }
            .navigationTitle("Profile")
        }
    }
}

struct UserSignUpFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpFormView()
    }
}

extension UserSignUpFormView {
    //MARK: Personal info
    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            //MARK: Personal Info
            HStack {
                userProfileIcon_Person
                Text("Personal Info")
                    .bold()
            }
            .foregroundColor(Color.assetColor.purple)
            TextFieldView(textInput: $vm.name, placeholder: "Name", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            TextFieldView(textInput: $vm.age, placeholder: "Age", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            TextFieldView(textInput: $vm.phoneNumber, placeholder: "Phone Number", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
                .keyboardType(.namePhonePad)
            TextFieldView(textInput: $vm.email, placeholder: "Email Adress", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 220, height: 25)
                .keyboardType(.emailAddress)
        }
    }
    //MARK: Preferences
    private var preferenceSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                userProfileIcon_Preference
                Text("Preferences")
                    .bold()
            }
            .foregroundColor(Color.assetColor.blue)
            
            Picker("Trainer Gender", selection: $vm.trainerGender) {
                ForEach(TrainerGender.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            TextFieldView(textInput: $vm.gymLocation, placeholder: "Gym Location", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            
            Picker("Preferred Gym", selection: $vm.preferredGym) {
                ForEach(PreferredGym.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            VStack(alignment: .leading, spacing: 1) {
                Picker("Workout Type 1", selection: $vm.typeOfWorkOut[0]) {
                    ForEach(vm.workoutTypesSelectable(0), id: \.self) {
                        Text($0.rawValue)
                            .tag("wotype1")
                    }
                }
                Picker("Workout Type 2", selection: $vm.typeOfWorkOut[1]) {
                    ForEach(vm.workoutTypesSelectable(1), id: \.self) {
                        Text($0.rawValue)
                            .tag("wotype2")
                    }
                }
                Picker("Workout Type 3", selection: $vm.typeOfWorkOut[2]) {
                    ForEach(vm.workoutTypesSelectable(2), id: \.self) {
                        Text($0.rawValue)
                            .tag("wotype3")
                    }
                }
//                Picker("Workout Type 2", selection: $vm.typeOfWorkOut[1]) {
//                    ForEach(vm.workoutTypesSelectable(1), id: \.self) {
//                        Text($0)
//                    }
//                }
//                Picker("Workout Type 3", selection: $vm.typeOfWorkOut[2]) {
//                    ForEach(vm.workoutTypesSelectable(2), id: \.self) {
//                        Text($0)
//                    }
//                }
            }
            
            HStack {
                Text("Price Range")
                Spacer()
                TextFieldView(textInput: $vm.priceRangeLow, placeholder: "0", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                TextFieldView(textInput: $vm.priceRangeHigh, placeholder: "100", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
            }
        }
    }
    
    //MARK: Metrics
    private var metricsSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                userProfileIcon_Health
                Text("Health Metrics")
                    .bold()
            }
            .foregroundColor(Color.assetColor.pink)
            .foregroundColor(.green)
            HStack {
                Text("Height")
                Spacer()
                TextFieldView(textInput: $vm.heightFt, placeholder: "ft", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 40, height: 25)
                Text("'").offset(x: -15)
                TextFieldView(textInput: $vm.heightIn, placeholder: "in", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 40, height: 25)
                Text("''").offset(x: -15)
            }
            HStack {
                Text("Skeletal Muscle Mass")
                Spacer()
                TextFieldView(textInput: $vm.skeletalMuscleMass, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
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
                HStack {
                    Text("Weight")
                    Spacer()
                    TextFieldView(textInput: $vm.currentWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                    TextFieldView(textInput: $vm.targetWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                }
                HStack {
                    Text("Body Fat")
                    Spacer()
                    TextFieldView(textInput: $vm.currentFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                    TextFieldView(textInput: $vm.targetFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                }
            }
        }
    }
}
