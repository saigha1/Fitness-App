//
//  UserSignUpFormView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI

struct UserSignUpFormView: View {    
    @StateObject private var signUpFormVM = UserSignUpFormViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 10) {
                        personalInfoSection
                        preferenceSection
                        metricsSection
                    }
                    if !signUpFormVM.error.isEmpty {
                        Text(signUpFormVM.error)
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                Button {
                    if signUpFormVM.validateForm(authVM.currentUser?.uid ?? UUID().uuidString) {
                        dismiss()
                    }
                } label: {
                    Text("Continue")
                        .bold()
                        .font(.title2)
                }
                
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem {
                    Button {
                        authVM.signOut()
                    } label: {
                        Text("Sign Out")
                    }
                }
            }
        }
        .onAppear {
            signUpFormVM.populateStates(authVM: authVM)
        }
    }
}

struct UserSignUpFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpFormView()
            .environmentObject(AuthViewModel())
    }
}

extension UserSignUpFormView {
    //MARK: Personal info
    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            //MARK: Profile Image
            HStack {
                Spacer()
                signUpFormVM.profileImage.asProfileImage(100)
                Spacer()
            }
            //MARK: Personal Info
            HStack {
                userProfileIcon_Person
                Text("Personal Info")
                    .bold()
            }
            .foregroundColor(Color.assetColor.purple)
            TextFieldView(textInput: $signUpFormVM.name, placeholder: "Name", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            TextFieldView(textInput: $signUpFormVM.age, placeholder: "Age", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            TextFieldView(textInput: $signUpFormVM.phoneNumber, placeholder: "Phone Number", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
                .keyboardType(.namePhonePad)
            TextFieldView(textInput: $signUpFormVM.email, placeholder: "Email Adress", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 220, height: 25)
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
            
            Picker("Trainer Gender", selection: $signUpFormVM.trainerGender) {
                ForEach(TrainerGender.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            TextFieldView(textInput: $signUpFormVM.gymLocation, placeholder: "Gym Location", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            
            Picker("Preferred Gym", selection: $signUpFormVM.preferredGym) {
                ForEach(PreferredGym.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            VStack(alignment: .leading, spacing: 1) {
                Picker("Workout Type 1", selection: $signUpFormVM.typeOfWorkOut[0]) {
                    ForEach(signUpFormVM.workoutTypesSelectable(0), id: \.self) {
                        Text($0.rawValue)
                            .tag("wotype1")
                    }
                }
                Picker("Workout Type 2", selection: $signUpFormVM.typeOfWorkOut[1]) {
                    ForEach(signUpFormVM.workoutTypesSelectable(1), id: \.self) {
                        Text($0.rawValue)
                            .tag("wotype2")
                    }
                }
                Picker("Workout Type 3", selection: $signUpFormVM.typeOfWorkOut[2]) {
                    ForEach(signUpFormVM.workoutTypesSelectable(2), id: \.self) {
                        Text($0.rawValue)
                            .tag("wotype3")
                    }
                }
            }
            
            HStack {
                Text("Price Range")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.priceRangeLow, placeholder: "0", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                TextFieldView(textInput: $signUpFormVM.priceRangeHigh, placeholder: "100", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
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
                TextFieldView(textInput: $signUpFormVM.heightFt, placeholder: "ft", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 40, height: 25)
                Text("'").offset(x: -15)
                TextFieldView(textInput: $signUpFormVM.heightIn, placeholder: "in", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 40, height: 25)
                Text("''").offset(x: -15)
            }
            HStack {
                Text("Skeletal Muscle Mass")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.skeletalMuscleMass, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
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
                    TextFieldView(textInput: $signUpFormVM.currentWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                    TextFieldView(textInput: $signUpFormVM.targetWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                }
                HStack {
                    Text("Body Fat")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.currentFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                    TextFieldView(textInput: $signUpFormVM.targetFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                }
            }
        }
    }
}
