//
//  UserProfileView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI
import Charts
struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var endUserProfileVM = EndUserProfileViewModel()
    @State var isEditing: Bool = false
    @State var showImagePicker: Bool = false
    @State var user: NewEndUser

    var body: some View {
        NavigationView {
            ScrollView {
                headerSection
                VStack(alignment: .leading, spacing: 15) {
                    ZStack {
                        GroupBox {
                            personalInfoSection
                        }
                        HStack {
                            Spacer()
                            VStack {
                                editButton
                                    .offset(y: -10)
                                Spacer()
                            }
                        }
                    }
                    GroupBox {
                        preferencesSection
                    }
                    GroupBox {
                        healthMetricsSection
                    }
                    GroupBox {
                        workoutJouneySection
                    }
                }
                .padding()
            }
            .onAppear {
                    user = authVM.currentEndUser!
                    endUserProfileVM.populateStates(user)
        }
        }
    }
}

//MARK: - Preview
struct UserProfileView_Previews: PreviewProvider {
    static let user: NewEndUser = NewEndUser(
        id: userIDMichaelLogan,
        name: "Michael Logan",
        profileImage: "User Profile Image",
        age: 23,
        phone: "437-123-1234",
        email: "mlogan2000@icloud.com",
        preferredTrainerGender: .m,
        gymLocation: "Etobicoke, ON",
        preferredGym: [.anytime, .fitForLess, .goodLife],
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
        UserProfileView(user: user)
            .environmentObject(AuthViewModel())
    }
}

//MARK: - Header
extension UserProfileView {
    private var dismissButton: some View {
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
    }
    private var profileImage: some View {
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
    }
    private var userName: some View {
        Text(authVM.currentEndUser!.name)
            .font(.title2)
            .bold()
            .padding(.trailing, 70)
    }
    private var headerSection: some View {
        Group {
            dismissButton
            HStack {
                profileImage
                userName
            }
        }
    }
}

//MARK: - Personal Info Section
extension UserProfileView {
    private var editButton: some View {
        Button {
            isEditing = isEditing ? false : true
            if !isEditing {
                endUserProfileVM.validateForm(user, authVM: authVM)
                authVM.refreshEndUserData(user.id)
                user = authVM.currentEndUser!
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 45, height: 45)
                    .shadow(color: .primary, radius: 5, x: 1, y: 1)
                if isEditing {
                    Text("Done")
                        .font(.footnote)
                } else {
                    Image(systemName: "square.and.pencil")
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
        .foregroundColor(.assetColor.purple)
    }
    private var age: some View {
        HStack {
            Text("Age")
                .bold()
            Spacer()
            Text("\(authVM.currentEndUser!.age)")
        }
    }
    private var phoneNumber: some View {
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
    }
    private var email: some View {
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
    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            titlePersonalInfo
            Divider()
            age
            phoneNumber
            email
        }
    }
}

//MARK: - Preferences Section
extension UserProfileView {
    private var titlePreferences: some View {
        HStack {
            userProfileIcon_Preference
            Text("Preferences")
                .bold()
        }
        .foregroundColor(Color.assetColor.blue)
    }
    private var trainerGender: some View {
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
    }
    private var gymLocation: some View {
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
    }
    private var preferredGym1: some View {
        Group {
            if isEditing {
                StyledPicker(title: "Preferred Gym 1") {
                    Picker("Preferred Gym 1", selection: $endUserProfileVM.preferredGyms[0]) {
                        ForEach(PreferredGym.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            } else {
                HStack {
                    Text("Preferred Gym 1")
                        .bold()
                    Spacer()
                    Text(authVM.currentEndUser!.preferredGym[0].rawValue)
                }
            }
        }
    }
    private var preferredGym2: some View {
        Group {
            if isEditing {
                StyledPicker(title: "Preferred Gym 2") {
                    Picker("Preferred Gym 2", selection: $endUserProfileVM.preferredGyms[1]) {
                        ForEach(PreferredGym.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            } else {
                HStack {
                    Text("Preferred Gym 2")
                        .bold()
                    Spacer()
                    Text(authVM.currentEndUser!.preferredGym[1].rawValue)
                }
            }
        }
    }
    private var preferredGym3: some View {
        Group {
            if isEditing {
                StyledPicker(title: "Preferred Gym 3") {
                    Picker("Preferred Gym 3", selection: $endUserProfileVM.preferredGyms[2]) {
                        ForEach(PreferredGym.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            } else {
                HStack {
                    Text("Preferred Gym 3")
                        .bold()
                    Spacer()
                    Text(authVM.currentEndUser!.preferredGym[2].rawValue)
                }
            }
        }
    }
    private var workoutType1: some View {
        Group {
            if isEditing {
                StyledPicker(title: "Workout Type 1") {
                    Picker("Workout Type 1", selection: $endUserProfileVM.typesOfWorkout[0]) {
                        ForEach(WorkOutType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            } else {
                HStack {
                    Text("Workout Type 1")
                        .bold()
                    Spacer()
                    Text(authVM.currentEndUser!.typesOfWorkOut[0].rawValue)
                }
            }
        }
    }
    private var workoutType2: some View {
        Group {
            if isEditing {
                StyledPicker(title: "Workout Type 2") {
                    Picker("Workout Type 2", selection: $endUserProfileVM.typesOfWorkout[1]) {
                        ForEach(WorkOutType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            } else {
                HStack {
                    Text("Workout Type 2")
                        .bold()
                    Spacer()
                    Text(authVM.currentEndUser!.typesOfWorkOut[0].rawValue)
                }
            }
        }
    }
    private var workoutType3: some View {
        Group {
            if isEditing {
                StyledPicker(title: "Workout Type 3") {
                    Picker("Workout Type 3", selection: $endUserProfileVM.typesOfWorkout[2]) {
                        ForEach(WorkOutType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            } else {
                HStack {
                    Text("Workout Type 3")
                        .bold()
                    Spacer()
                    Text(authVM.currentEndUser!.typesOfWorkOut[2].rawValue)
                }
            }
        }
    }
    private var priceRange: some View {
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
    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            titlePreferences
            Divider()
            trainerGender
            gymLocation
            GroupBox {
                preferredGym1
                preferredGym2
                preferredGym3
            }
            GroupBox {
                workoutType1
                workoutType2
                workoutType3
            }
            priceRange
        }
    }
}

//MARK: - Health Metrics Section
extension UserProfileView {
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
    }
    private var skeletalMuscleMass: some View {
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
    }
    private var weight: some View {
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
    }
    private var fat: some View {
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
    private var healthMetricsSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            titleMetrics
            Divider()
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
                fat
            }
        }
    }
}

