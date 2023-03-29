//
//  UserSignUpFormViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 2/14/23.
//

import Foundation
import UIKit

class UserSignUpFormViewModel: ObservableObject {
    // State string for the error message
    @Published var error: String = ""
    //State properties for fields
    @Published var profileImage: String = ""
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var trainerGender: TrainerGender = .m
    @Published var preferredGyms: [PreferredGym] = [.none, .none, .none]
    @Published var gymLocation: String = ""
    @Published var typesOfWorkOut: [WorkOutType] = [.none, .none, .none]
    @Published var priceRangeLow: String = ""
    @Published var priceRangeHigh: String = ""
    @Published var heightFt: String = "" // 5
    @Published var heightIn: String = "" // 7
    @Published var skeletalMuscleMass: String = ""
    @Published var currentWeight: String = ""
    @Published var targetWeight: String = ""
    @Published var currentFatPercentage: String = ""
    @Published var targetFatPercentage: String = ""
    @Published var selectedImages: [UIImage] = []
    
    var ageToStore: Int = 0
    var phoneNumberToStore: String = ""
    var emailToStore: String = ""
    
    var priceRangeLowToStore: Double = 0
    var priceRangeHighToStore: Double = 0
    
    var heightFtToStore: Int = 0
    var heightInToStore: Double = 0
    var skeletalMuscleMassToStore: Double = 0
    
    var currentWeightToStore: Double = 0
    var targetWeightToStore: Double = 0
    var currentFatPercentageToStore: Double = 0
    var targetFatPercentageToStore: Double = 0
    
    // filter for workout type
    func workoutTypesSelectable(_ index: Int) -> [WorkOutType] {
        WorkOutType.allCases.filter { !typesOfWorkOut.contains($0) } + [typesOfWorkOut[index]]
    }
    func preferredGymSelectedable(_ index: Int) -> [PreferredGym] {
        PreferredGym.allCases.filter{ !preferredGyms.contains($0) } + [preferredGyms[index]]
    }
    
    func validateForm(_ firebaseUID: String) -> Bool {
        var newUserCreated = false
        // check if all validation functions returns true
        guard validateName() else { return false }
        guard validateAge() else { return false }
        guard validatePhoneNum() else { return false }
        guard validateEmail() else { return false }
        guard validateGymLocation() else { return false }
        guard validatePreferredGym() else { return false }
        guard validateWorkoutTypes() else { return false }
        guard validatePriceRange() else { return false }
        guard validateHeight() else { return false }
        guard validateMuscleMass() else { return false }
        guard validateWeight() else { return false }
        guard validateBodyFat() else { return false }
        
        let usersBeforeCreating: [NewEndUser] = load(filename: "EndUser.json", location: .document) ?? []
        print(usersBeforeCreating.count)
        
        
        // create new user and save to JSON in .document directory
        let newUser = NewEndUser(
            id: firebaseUID,
            name: name,
            profileImage: profileImage,
            age: ageToStore,
            phone: phoneNumberToStore,
            email: emailToStore,
            preferredTrainerGender: trainerGender,
            gymLocation: gymLocation,
            preferredGym: preferredGyms,
            typesOfWorkOut: typesOfWorkOut,
            preferredPriceRange: PriceRange(
                currency: Currency.cad,
                min: priceRangeLowToStore,
                max: priceRangeHighToStore
            ),
            heightFt: heightFtToStore,
            heightIn: heightInToStore,
            skeletalMuscleMass: skeletalMuscleMassToStore,
            currentWeight: currentWeightToStore,
            targetWeight: targetWeightToStore,
            currentBodyFat: currentFatPercentageToStore,
            targetBodyFat: targetFatPercentageToStore
        )
        add(newEntry: newUser, filename: "EndUser.json", location: .document)
        
        let usersAfterCreating: [NewEndUser] = load(filename: "EndUser.json", location: .document) ?? []
        print(usersAfterCreating.count)
        
        if usersAfterCreating.count > usersBeforeCreating.count { newUserCreated.toggle() }
        return newUserCreated
    }
}

//MARK: Validation functions
extension UserSignUpFormViewModel {
    private func validateName() -> Bool {
        // name
        if !name.isEmpty && name.count >= 2 {
            error = ""
            return true
        } else {
            error = "Invalid name"
            return false
        }
    }
    private func validateAge() -> Bool {
        // age
        if let ageToStore = Int(age) {
            error = ""
            self.ageToStore = ageToStore
            return true
        } else {
            error = "Invalid age."
            return false
        }
    }
    private func validatePhoneNum() -> Bool {
        // phone number
        if phoneNumber.isNumeric && phoneNumber.count == 10 {
            error = ""
            self.phoneNumberToStore = phoneNumber
            return true
        } else {
            error = "Invalid phone number."
            return false
        }
    }
    
    private func validateEmail() -> Bool {
        // email
        if !email.isEmpty && email.isEmail {
            error = ""
            self.emailToStore = email
            return true
        } else {
            error = "Invalid email."
            return false
        }
    }
    
    private func validateGymLocation() -> Bool {
        if gymLocation.isEmpty {
            error = "Invalid Gym Location"
            return false
        } else {
            return true
        }
    }
    
    private func validateWorkoutTypes() -> Bool {
        let isValid = typesOfWorkOut[0] != .none
        if !isValid {
            error = "Please select a workout type."
        }
        return isValid
    }
    
    private func validatePreferredGym() -> Bool {
        let isValid = preferredGyms[0] != .none
        if !isValid {
            error = "Please select a preferred gym."
        }
        return isValid
    }
    
    private func validatePriceRange() -> Bool {
        //priceRange
        if let low = Double(priceRangeLow), let high = Double(priceRangeHigh), low <= high {
            error = ""
            self.priceRangeLowToStore = low
            self.priceRangeHighToStore = high
            return true
        } else {
            error = "Invalid price range."
            return false
        }
    }
    //MARK: Validate health metrics
    private func validateHeight() -> Bool {
        //height
        if let ft = Int(heightFt), let inch = Double(heightIn), ft > 0 {
            error = ""
            self.heightFtToStore = ft
            self.heightInToStore = inch
            return true
        } else {
            error = "Invalid height."
            return false
        }
    }
    private func validateMuscleMass() -> Bool {
        // skeletal muscle mass
        if let mass = Double(skeletalMuscleMass) {
            error = ""
            self.skeletalMuscleMassToStore = mass
            return true
        } else {
            error = "Invalid muscle mass."
            return false
        }
    }
    private func validateWeight() -> Bool {
        // weight
        if let current = Double(currentWeight), let target = Double(targetWeight) {
            error = ""
            self.currentWeightToStore = current
            self.targetWeightToStore = target
            return true
        } else {
            error = "Invalid weight."
            return false
        }
    }
    private func validateBodyFat() -> Bool {
        // body fat
        if let current = Double(currentFatPercentage), let target = Double(targetFatPercentage), current < 100, target < 100 {
            error = ""
            self.currentFatPercentageToStore = current
            self.targetFatPercentageToStore = target
            return true
        } else {
            error = "Invalid body fat."
            return false
        }
    }
}


//MARK: States
extension UserSignUpFormViewModel {
    // Populate states fields in end user sign up form view
    @MainActor func populateStates(authVM: AuthViewModel) {
        #if DEBUG
        print(authVM.currentUser?.uid ?? "")
        #endif
        guard let firebaseUser = authVM.currentUser else { return }
        name = firebaseUser.displayName ?? ""
        phoneNumber = firebaseUser.phoneNumber ?? ""
        email = firebaseUser.email ?? ""
        profileImage = firebaseUser.photoURL?.absoluteString ?? ""
    }
    func updateProfileImage() {
        guard let image = selectedImages.first else { return }
        //guard let imageData = image.pngData() else { return }
        // Changed to jpeg data to compress data size
        guard let imageData = image.jpegData(compressionQuality: 0.09) else { return }
        profileImage = "data:image/jpeg;base64," + imageData.base64EncodedString()
    }
}
