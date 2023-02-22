//
//  UserSignUpFormViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 2/14/23.
//

import Foundation

class UserSignUpFormViewModel: ObservableObject {
    // State string for the error message
    @Published var error: String = ""
    //State properties for fields
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var trainerGender: String = "Male"
    @Published var gymLocation: String = ""
    @Published var typeOfWorkOut: [String] = [workoutTypes[0], workoutTypes[1], workoutTypes[2]]
    @Published var priceRangeLow: String = ""
    @Published var priceRangeHigh: String = ""
    @Published var heightFt: String = "" // 5
    @Published var heightIn: String = "" // 7
    @Published var skeletalMuscleMass: String = ""
    @Published var currentWeight: String = ""
    @Published var targetWeight: String = ""
    @Published var currentFatPercentage: String = ""
    @Published var targetFatPercentage: String = ""
    
    var ageToStore: Int = 0
    var phoneNumberToStore: String = ""
    var emailToStore: String = ""
    
    var trainerGenderToStore: String = ""
    var gymLocationToStore: String = ""
    var typeOfWorkoutToStore: [String] = []
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
    func workoutTypesSelectable(_ index: Int) -> [String] {
        [typeOfWorkOut[index]] +
        workoutTypes.filter { type in
            !typeOfWorkOut.contains(type)
        }
    }
    
    func validateForm() {
        // check if all validation functions returns true
        guard validateName() else { return }
        guard validateAge() else { return }
        guard validatePhoneNum() else { return }
        guard validateEmail() else { return }
        guard validateTrainerGender() else { return }
        guard validateWorkoutTypes() else { return }
        guard validatePriceRange() else { return }
        guard validateHeight() else { return }
        guard validateMuscleMass() else { return }
        guard validateWeight() else { return }
        guard validateBodyFat() else { return }
        #if DEBUG
        let usersBeforeCreating: [EndUser] = load(filename: "EndUser.json", location: .document) ?? []
        print(usersBeforeCreating.count)
        #endif
        
        // create new user and save to JSON in .document directory
        let newUser = EndUser(
            id: UUID().uuidString,
            name: name,
            profileImageName: "",
            age: ageToStore,
            phone: phoneNumberToStore,
            email: emailToStore,
            preferredTrainerGender: trainerGenderToStore,
            gymLocation: gymLocationToStore,
            typesOfWorkOut: typeOfWorkoutToStore,
            preferredPriceRange: PriceRangePrefrence(
                currency: "CAD",
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
        #if DEBUG
        let usersAfterCreating: [EndUser] = load(filename: "EndUser.json", location: .document) ?? []
        print(usersAfterCreating.count)
        #endif
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
    private func validateTrainerGender() -> Bool {
        // trainergender
        if genders.contains(trainerGender) {
            error = ""
            self.trainerGenderToStore = trainerGender
            return true
        } else {
            error = "Invalid gender."
            return false
        }
    }
    
    //TODO: Fetch/Validate gym location
    
    private func validateWorkoutTypes() -> Bool {
        // type of workout
        var validCount: Int = 0
        for i in typeOfWorkOut {
            if workoutTypes.contains(i) {
                validCount += 1
            }
        }
        return validCount == 3
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
