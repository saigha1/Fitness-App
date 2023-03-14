//
//  EndUserProfileViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 3/7/23.
//

import Foundation
import UIKit

@MainActor
class EndUserProfileViewModel: ObservableObject {
    //MARK: - Published Properties for form inputs and error message
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var gymLoocation: String = ""
    @Published var typesOfWorkout: [WorkOutType] = []
    @Published var preferredGyms: [PreferredGym] = []
    @Published var selectedPTGender: TrainerGender = .m
    @Published var priceRangeLow: String = ""
    @Published var priceRangeHigh: String = ""
    @Published var heightFt: String = ""
    @Published var heightIn: String = ""
    @Published var skeletalMuscleMass: String = ""
    @Published var currentWeight: String = ""
    @Published var targetWeight: String = ""
    @Published var currentFatPercentage: String = ""
    @Published var targetFatPercentage: String = ""
    @Published var selectedImages: [UIImage] = []
    @Published var showError: Bool = false
    @Published var error: String = ""
    
    //MARK: - Private properties to hold the values for user creation
    private var phoneNumberToStore: String = ""
    private var emailToStore: String = ""
    private var priceRangeLowToStore: Double = 0
    private var priceRangeHighToStore: Double = 0
    private var heightFtToStore: Int = 0
    private var heightInToStore: Double = 0
    private var skeletalMuscleMassToStore: Double = 0
    private var currentWeightToStore: Double = 0
    private var targetWeightToStore: Double = 0
    private var currentFatPercentageToStore: Double = 0
    private var targetFatPercentageToStore: Double = 0
    private var profileImageToStore: String = ""
    
    //MARK: - User Creation
    func populateStates(_ user: NewEndUser) {
        phoneNumber = user.phone
        email = user.email
        gymLoocation = user.gymLocation
        typesOfWorkout = user.typesOfWorkOut
        preferredGyms = user.preferredGym
        selectedPTGender = user.preferredTrainerGender
        priceRangeLow = user.preferredPriceRange.min.asStringWith2Decimals()
        priceRangeHigh = user.preferredPriceRange.max.asStringWith2Decimals()
        heightFt = "\(user.heightFt)"
        heightIn = "\(user.heightIn.asStringWith2Decimals())"
        skeletalMuscleMass = "\(user.skeletalMuscleMass.asStringWith2Decimals())"
        currentWeight = "\(user.currentWeight.asStringWith2Decimals())"
        targetWeight = "\(user.targetWeight.asStringWith2Decimals())"
        currentFatPercentage = "\(user.currentBodyFat.asStringWith2Decimals())"
        targetFatPercentage = "\(user.targetBodyFat.asStringWith2Decimals())"
        showError = false
        error = ""
    }
    
    //MARK: - Form Validation
    func validateForm(_ user: NewEndUser, authVM: AuthViewModel) {
        var hasChange = false
        // check if changes are made
        if !selectedImages.isEmpty { hasChange = true }
        if phoneNumber != user.phone { hasChange = true }
        if email != user.email { hasChange = true }
        if gymLoocation != user.gymLocation { hasChange = true }
        if typesOfWorkout != user.typesOfWorkOut { hasChange = true }
        if preferredGyms != user.preferredGym { hasChange = true }
        if selectedPTGender != user.preferredTrainerGender { hasChange = true }
        if priceRangeLow != user.preferredPriceRange.min.asStringWith2Decimals() { hasChange = true }
        if priceRangeHigh != user.preferredPriceRange.max.asStringWith2Decimals() { hasChange = true }
        if heightFt != "\(user.heightFt)" { hasChange = true }
        if heightIn != user.heightIn.asStringWith2Decimals() { hasChange = true }
        if skeletalMuscleMass != user.skeletalMuscleMass.asStringWith2Decimals() { hasChange = true }
        if currentWeight != user.currentWeight.asStringWith2Decimals() { hasChange = true }
        if targetWeight != user.targetWeight.asStringWith2Decimals() { hasChange = true }
        if currentFatPercentage != user.currentBodyFat.asStringWith2Decimals() { hasChange = true }
        if targetFatPercentage != user.targetBodyFat.asStringWith2Decimals() { hasChange = true }
        guard hasChange else { return } // won’t update JSON if no change is made
        
        // check if all validation functions returns true
        guard validatePhoneNum() else { return }
        guard validateEmail() else { return }
        guard validateGymLocation() else { return }
        guard validatePriceRange() else { return }
        guard validateHeight() else { return }
        guard validateMuscleMass() else { return }
        guard validateWeight() else { return }
        guard validateBodyFat() else { return }
        guard validateImage(user) else { return }
        guard validatePreferredGym() else { return }
        guard validateWorkoutType() else { return }
        // get the current user from JSON
        guard let users: [NewEndUser] = load(filename: "EndUser.json", location: .document) else { return }
        guard let userfound = users.first(where: { $0.id == user.id }) else { return }
        
        // create new user and save to JSON in .document directory
        let userUpdated = NewEndUser(
            id: userfound.id,
            name: userfound.name,
            profileImage: selectedImages.isEmpty ? user.profileImage : profileImageToStore,
            age: userfound.age,
            phone: phoneNumberToStore,
            email: emailToStore,
            preferredTrainerGender: selectedPTGender,
            gymLocation: gymLoocation,
            preferredGym: preferredGyms,
            typesOfWorkOut: typesOfWorkout,
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
        //add(newEntry: newUser, filename: "EndUser.json", location: .document)
        update(old: userfound, new: userUpdated, filename: "EndUser.json", location: .document)
        authVM.refreshEndUserData(user.id)
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
        if gymLoocation.isEmpty {
            error = "Invalid Gym Location"
            return false
        } else {
            return true
        }
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
    private func validateImage(_ user: NewEndUser) -> Bool {
        if selectedImages.isEmpty {
            profileImageToStore = user.profileImage
            return true
        } else {
            guard let newImage = selectedImages.first else { return false }
            //guard let imageData = image.pngData() else { return }
            // Changed to jpeg data to compress data size
            guard let imageData = newImage.jpegData(compressionQuality: 0.09) else { return false }
            profileImageToStore = "data:image/jpeg;base64," + imageData.base64EncodedString()
        }
        return true
    }
    private func validatePreferredGym() -> Bool {
        var isValid = true
        for gym in preferredGyms {
            if gym == .none {
                isValid = false
            }
        }
        if !isValid {
            error = "Please select a preferred gym."
        }
        return isValid
    }
    private func validateWorkoutType() -> Bool {
        var isValid = true
        for type in typesOfWorkout {
            if type == .none {
                isValid = false
            }
        }
        if !isValid {
            error = "Please select a workout type."
        }
        return isValid
    }
}
