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
    
    @State private var showImagePicker: Bool = false
    @State private var numberOfPickersShownGym: Int = 1
    @State private var numberOfPickersShownWorkoutType: Int = 1
    var body: some View {
        NavigationView {
            ScrollView {
                profileImageSection
                personalInfoSection
                    Divider()
                preferenceSection
                    Divider()
                metricsSection
                errorMessage
                continueButton
            }
            .padding()
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

//MARK: - Preview
struct UserSignUpFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpFormView()
            .environmentObject(AuthViewModel())
    }
}

//MARK: - Form Components
extension UserSignUpFormView {
    private var continueButton: some View {
        Button {
            var userID: String
            if authVM.currentUser == nil {
                userID = UUID().uuidString
            } else {
                userID = authVM.currentUser!.uid
            }
            if signUpFormVM.validateForm(userID) {
                if authVM.endUserApprovalCheck() {
                    dismiss()
                }
            }
        } label: {
            Text("Continue")
                .bold()
                .font(.title2)
        }
    }
    private var errorMessage: some View {
        Group {
            if !signUpFormVM.error.isEmpty {
                Text(signUpFormVM.error)
                    .bold()
                    .foregroundColor(.red)
            }
        }
    }
}


//MARK: - Personal Information Components
extension UserSignUpFormView {
    private var profileImageSection: some View {
        VStack {
            signUpFormVM.profileImage.asProfileImage(100)
                .onTapGesture {
                    showImagePicker.toggle()
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $signUpFormVM.selectedImages, selectionLimit: 1)
                        .onChange(of: signUpFormVM.selectedImages) { _ in
                            signUpFormVM.updateProfileImage()
                        }
                }
        }
    }
    private var titlePersonalInfo: some View {
        HStack {
            userProfileIcon_Person
            Text("Personal Info")
                .bold()
        }
        .foregroundColor(Color.assetColor.purple)
    }
    private var name: some View {
        Group {
            HStack {
                Text("Name")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.name, placeholder: "Name", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            }
        }
    }
    private var age: some View {
        Group {
            HStack {
                Text("Age")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.age, placeholder: "Age", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            }
        }
    }
    private var phoneNumber: some View {
        Group {
            HStack {
                Text("Phone Number")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.phoneNumber, placeholder: "Phone Number", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
                    .keyboardType(.phonePad)
            }
        }
    }
    private var email: some View {
        Group {
            HStack {
                Text("Email")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.email, placeholder: "Email Adress", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 220, height: 25)
                    .keyboardType(.emailAddress)
            }
        }
    }
    private var personalInfoSection: some View {
        VStack(alignment: .leading) {
            titlePersonalInfo
            name
            age
            phoneNumber
            email
        }
    }
}

//MARK: - Preferences Components
extension UserSignUpFormView {
    private var titlePreferences: some View {
        HStack {
            userProfileIcon_Preference
            Text("Preferences")
                .bold()
        }
        .foregroundColor(Color.assetColor.blue)
    }
    private var trainerGenderPicker: some View {
        Picker("Trainer Gender", selection: $signUpFormVM.trainerGender) {
            ForEach(TrainerGender.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
    }
    private var trainerGender: some View {
        Group {
            if #available(iOS 16.0, *) {
                trainerGenderPicker
                    .pickerStyle(.navigationLink)
            } else {
                HStack {
                    Text("Trainer Gender")
                    Spacer()
                    trainerGenderPicker
                        .pickerStyle(.menu)
                }
            }
        }
    }
    private var gymLocation: some View {
        Group {
            HStack {
                Text("Gym Location")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.gymLocation, placeholder: "Gym Location", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
            }
        }
    }
    private var workoutType1Picker: some View {
        Picker("Workout Type 1", selection: $signUpFormVM.typesOfWorkOut[0]) {
            ForEach(signUpFormVM.workoutTypesSelectable(0), id: \.self) {
                Text($0.rawValue)
                    .tag("wotype1")
            }
        }
    }
    private var workoutType2Picker: some View {
        Picker("Workout Type 2", selection: $signUpFormVM.typesOfWorkOut[1]) {
            ForEach(signUpFormVM.workoutTypesSelectable(1), id: \.self) {
                Text($0.rawValue)
                    .tag("wotype2")
            }
        }
    }
    private var workoutType3Picker: some View {
        Picker("Workout Type 3", selection: $signUpFormVM.typesOfWorkOut[2]) {
            ForEach(signUpFormVM.workoutTypesSelectable(2), id: \.self) {
                Text($0.rawValue)
                    .tag("wotype3")
            }
        }
    }
    private var preferredGym1Picker: some View {
        Picker("Preferred Gym 1", selection: $signUpFormVM.preferredGyms[0]) {
            ForEach(signUpFormVM.preferredGymSelectedable(0), id: \.self) {
                Text($0.rawValue)
            }
        }
    }
    private var preferredGym2Picker: some View {
        Picker("Preferred Gym 2", selection: $signUpFormVM.preferredGyms[1]) {
            ForEach(signUpFormVM.preferredGymSelectedable(1), id: \.self) {
                Text($0.rawValue)
            }
        }
    }
    private var preferredGym3Picker: some View {
        Picker("Preferred Gym 3", selection: $signUpFormVM.preferredGyms[2]) {
            ForEach(signUpFormVM.preferredGymSelectedable(2), id: \.self) {
                Text($0.rawValue)
            }
        }
    }
    private var preferredGymPickersGroup: some View {
        GroupBox {
            StyledPicker(title: "Preferred Gym 1", picker: { preferredGym1Picker })
            StyledPicker(title: "Preferred Gym 2", picker: { preferredGym2Picker })
            .if(numberOfPickersShownGym < 2) { _ in
                EmptyView()
            }
            StyledPicker(title: "Preferred Gym 3", picker: { preferredGym3Picker })
            .if(numberOfPickersShownGym < 3) { _ in
                EmptyView()
            }
            Group {
                HStack {
                    Spacer()
                    // remove
                    Button {
                        if numberOfPickersShownGym > 1 {
                            numberOfPickersShownGym -= 1
                            signUpFormVM.preferredGyms[numberOfPickersShownGym] = .none
                        }
                    } label: {
                        Label("Remove", systemImage: "minus.circle.fill")
                        
                            .padding(.horizontal, UIScreen.main.bounds.width / 10)
                            .padding(.vertical, 5)
                            .foregroundColor(.red)
                    }
                    .foregroundColor(.gray)
                    .if(numberOfPickersShownGym == 1) { _ in
                        EmptyView()
                    }
                    // add
                    Button {
                        if numberOfPickersShownGym < 3 {
                            numberOfPickersShownGym += 1
                        }
                    } label: {
                        Label("Add", systemImage: "plus.circle.fill")
                            .padding(.horizontal, UIScreen.main.bounds.width / 10)
                            .padding(.vertical, 5)
                            .foregroundColor(.accentColor)
                    }
                    .if(numberOfPickersShownGym == 3 || (numberOfPickersShownGym == 2 && signUpFormVM.preferredGyms[1] == .none)) { _ in
                        EmptyView()
                    }
                    Spacer()
                }
            }
            .if(signUpFormVM.preferredGyms[0] == .none) { _ in
                EmptyView()
            }
            
        }
    }
    private var workoutTypePickersGroup: some View {
        GroupBox {
            StyledPicker(title: "Workout Type 1", picker: { workoutType1Picker })
            StyledPicker(title: "Workout Type 2", picker: { workoutType2Picker })
            .if(numberOfPickersShownWorkoutType < 2) { _ in
                EmptyView()
            }
            StyledPicker(title: "Workout Type 3", picker: { workoutType3Picker })
            .if(numberOfPickersShownWorkoutType < 3) { _ in
                EmptyView()
            }
            Group {
                HStack {
                    Spacer()
                    // remove
                    Button {
                        if numberOfPickersShownWorkoutType > 1 {
                            numberOfPickersShownWorkoutType -= 1
                            signUpFormVM.typesOfWorkOut[numberOfPickersShownWorkoutType] = .none
                        }
                    } label: {
                        Label("Remove", systemImage: "minus.circle.fill")
                        
                            .padding(.horizontal, UIScreen.main.bounds.width / 10)
                            .padding(.vertical, 5)
                            .foregroundColor(.red)
                    }
                    .foregroundColor(.gray)
                    .if(numberOfPickersShownWorkoutType == 1) { _ in
                        EmptyView()
                    }
                    // add
                    Button {
                        if numberOfPickersShownWorkoutType < 3 {
                            numberOfPickersShownWorkoutType += 1
                        }
                    } label: {
                        Label("Add", systemImage: "plus.circle.fill")
                            .padding(.horizontal, UIScreen.main.bounds.width / 10)
                            .padding(.vertical, 5)
                            .foregroundColor(.accentColor)
                    }
                    .if(numberOfPickersShownWorkoutType == 3 || (numberOfPickersShownWorkoutType == 2 && signUpFormVM.typesOfWorkOut[1] == .none)) { _ in
                        EmptyView()
                    }
                    Spacer()
                }
            }
            .if(signUpFormVM.typesOfWorkOut[0] == .none) { _ in
                EmptyView()
            }
            
        }
    }
    private var priceRange: some View {
        Group {
            HStack {
                Text("Price Range")
                Spacer()
                TextFieldView(textInput: $signUpFormVM.priceRangeLow, placeholder: "0", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                TextFieldView(textInput: $signUpFormVM.priceRangeHigh, placeholder: "100", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
            }
        }
    }
    private var preferenceSection: some View {
        VStack(alignment: .leading) {
            titlePreferences
            trainerGender
            gymLocation
            preferredGymPickersGroup
            workoutTypePickersGroup
            priceRange
        }
    }
}

//MARK: - Metrics Components
extension UserSignUpFormView {
    private var titleMetrics: some View {
        HStack {
            userProfileIcon_Health
            Text("Health Metrics")
                .bold()
        }
        .foregroundColor(Color.assetColor.pink)
        .foregroundColor(.green)
    }
    private var height: some View {
        HStack {
            Text("Height")
            Spacer()
            TextFieldView(textInput: $signUpFormVM.heightFt, placeholder: "ft", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 40, height: 25)
                .keyboardType(.numberPad)
            Text("'").offset(x: -15)
            TextFieldView(textInput: $signUpFormVM.heightIn, placeholder: "in", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 40, height: 25)
                .keyboardType(.decimalPad)
            Text("''").offset(x: -15)
        }
    }
    private var skeletalMuscleMass: some View {
        HStack {
            Text("Skeletal Muscle Mass")
            Spacer()
            TextFieldView(textInput: $signUpFormVM.skeletalMuscleMass, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
        }
    }
    private var weight: some View {
        HStack {
            Text("Weight")
            Spacer()
            TextFieldView(textInput: $signUpFormVM.currentWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                .keyboardType(.decimalPad)
            TextFieldView(textInput: $signUpFormVM.targetWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                .keyboardType(.decimalPad)
        }
    }
    private var bodyFat: some View {
        HStack {
            Text("Body Fat")
            Spacer()
            TextFieldView(textInput: $signUpFormVM.currentFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                .keyboardType(.decimalPad)
            TextFieldView(textInput: $signUpFormVM.targetFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                .keyboardType(.decimalPad)
        }
    }
    private var metricsSection: some View {
        VStack(alignment: .leading) {
            titleMetrics
            height
            skeletalMuscleMass
            Group {
                HStack {
                    Spacer()
                    Text("Current")
                    Text("Target")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.trailing, 20)
                weight
                bodyFat
            }
        }
    }
}


