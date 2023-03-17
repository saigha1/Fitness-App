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
    var body: some View {
        NavigationView {
            ScrollView {
                profileImageSection
                personalInfoSection
                    Divider()
                preferenceSection
                    Divider()
                metricsSection
               
                if !signUpFormVM.error.isEmpty {
                    Text(signUpFormVM.error)
                        .bold()
                        .foregroundColor(.red)
                }
                
                Button {
                    var userID: String
                    if authVM.currentUser == nil {
                        userID = UUID().uuidString
                    } else {
                        userID = authVM.currentUser!.uid
                    }
                    if signUpFormVM.validateForm(userID) {
//                    if signUpFormVM.validateForm((authVM.currentUser?.uid) ?? (UUID().uuidString)) {
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

struct UserSignUpFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpFormView()
            .environmentObject(AuthViewModel())
    }
}

extension UserSignUpFormView {
    //MARK: Profile Image
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
    //MARK: Personal info
    private var personalInfoSection: some View {
        VStack(alignment: .leading) {
            HStack {
                userProfileIcon_Person
                Text("Personal Info")
                    .bold()
            }
            .foregroundColor(Color.assetColor.purple)
            Group {
                HStack {
                    Text("Name")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.name, placeholder: "Name", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
                }
            }
            Group {
                HStack {
                    Text("Age")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.age, placeholder: "Age", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
                }
            }
            Group {
                HStack {
                    Text("Phone Number")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.phoneNumber, placeholder: "Phone Number", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
                        .keyboardType(.phonePad)
                }
            }
            Group {
                HStack {
                    Text("Email")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.email, placeholder: "Email Adress", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 220, height: 25)
                        .keyboardType(.emailAddress)
                }
            }
        }
    }
    //MARK: Preferences
    private var preferenceSection: some View {
        VStack(alignment: .leading) {
            HStack {
                userProfileIcon_Preference
                Text("Preferences")
                    .bold()
            }
            .foregroundColor(Color.assetColor.blue)
            
            Group {
                HStack {
                    Text("Trainer Gender")
                    Spacer()
                    Picker("Trainer Gender", selection: $signUpFormVM.trainerGender) {
                        ForEach(TrainerGender.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            
            Group {
                HStack {
                    Text("Gym Location")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.gymLocation, placeholder: "Gym Location", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 150, height: 25)
                }
            }
            Group {
                HStack {
                    Text("Preferred Gym")
                    Spacer()
                    Picker("Preferred Gym", selection: $signUpFormVM.preferredGym) {
                        ForEach(PreferredGym.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            }
            Group {
                HStack {
                    Text("Workout Type 1")
                    Spacer()
                    Picker("Workout Type 1", selection: $signUpFormVM.typeOfWorkOut[0]) {
                        ForEach(signUpFormVM.workoutTypesSelectable(0), id: \.self) {
                            Text($0.rawValue)
                                .tag("wotype1")
                        }
                    }
                }
                HStack {
                    Text("Workout Type 2")
                    Spacer()
                    Picker("Workout Type 2", selection: $signUpFormVM.typeOfWorkOut[1]) {
                        ForEach(signUpFormVM.workoutTypesSelectable(1), id: \.self) {
                            Text($0.rawValue)
                                .tag("wotype2")
                        }
                    }}
                HStack {
                    Text("Workout Type 3")
                    Spacer()
                    Picker("Workout Type 3", selection: $signUpFormVM.typeOfWorkOut[2]) {
                        ForEach(signUpFormVM.workoutTypesSelectable(2), id: \.self) {
                            Text($0.rawValue)
                                .tag("wotype3")
                        }
                    }
                }
            }
            Group {
                HStack {
                    Text("Price Range")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.priceRangeLow, placeholder: "0", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                    TextFieldView(textInput: $signUpFormVM.priceRangeHigh, placeholder: "100", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 70, height: 25)
                }
            }
        }
    }
    
    //MARK: Metrics
    private var metricsSection: some View {
        VStack(alignment: .leading) {
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
                    .keyboardType(.numberPad)
                Text("'").offset(x: -15)
                TextFieldView(textInput: $signUpFormVM.heightIn, placeholder: "in", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 40, height: 25)
                    .keyboardType(.decimalPad)
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
                        .keyboardType(.decimalPad)
                    TextFieldView(textInput: $signUpFormVM.targetWeight, placeholder: "lbs", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Body Fat")
                    Spacer()
                    TextFieldView(textInput: $signUpFormVM.currentFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                        .keyboardType(.decimalPad)
                    TextFieldView(textInput: $signUpFormVM.targetFatPercentage, placeholder: "%", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 50, height: 25)
                        .keyboardType(.decimalPad)
                }
            }
        }
    }
}
