//
//  PTValidationModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-03-03.
//

import Foundation

class PTValidationModel: ObservableObject {
    
    // State string for the error message
    @Published var error: String = ""
    //State properties for fields
    @Published var name: String = ""
    @Published var trainerGender: String = "Male"
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var experienceLevel : PTexperienceLevel = .One
    @Published var education: PTEducationLevel = .Bachelors
    @Published var Certification: [certificates] = []
    @Published var city : gymLocation = .Mississauga

    @Published var typeOfExercise: [typesOfWorkOut] = [.calisthenic, .americanBoxing, .weights, .machine]
    @Published var Description: String = ""
    @Published var Motto: String = ""
    @Published var isFeaturedToStore: Bool = false
    @Published var isFavoriteToStore: Bool = false
    @Published var isProfImg: String = ""
    @Published var gymPreferencePublished : [gymPreferrence] = [.GoodLife, .UFC, .FitnessPlanet, .LAFitness]
    
    var nameToStore: Int = 0
    
    var ageToStore: Int = 0
    var phoneNumberToStore: String = ""
    var emailToStore: String = ""
    
//    var selectedGender
    var trainersGenderToStore: String = ""
    var gymLocationToStore: String = ""
    var workoutTypesToStore: [String] = []
    
    
    func workoutTypesSelectable(_ index: Int) -> [typesOfWorkOut]{
        let workoutTypes = typesOfWorkOut.allCases
        return [typeOfExercise[index]] +
        workoutTypes.filter { type in
            !typeOfExercise.contains(type)
        }
    }
    
    func validateForm() {
        // check if all validation functions returns true
        guard validateName() else { return }
        guard validateGender() else { return}
//        guard validateAge() else { return }
        guard validatePhoneNum() else { return }
//        guard validateEmail() else { return } => Not necessary
//        guard validateWorkoutTypes() else { return }

        #if DEBUG
//        let usersBeforeCreating: [EndUser] = load(filename: "EndUser.json", location: .document) ?? []
//        print(usersBeforeCreating.count)
        #endif
        
        // create new user and save to JSON in .document directory
//        let newPT = PTModel(
//            id: UUID().uuidString,
//            name: name,
//            gender: trainersGenderToStore,
//            phone: phoneNumberToStore,
//            email: emailToStore,
//            isFeatured: isFeaturedToStore,
//            isFavorite: isFavoriteToStore,
//            description: Description,
//            motto: Motto,
//            profileImg: isProfImg,
//            education: education,
//            certification: Certification,
//            selectedExperience: experienceLevel,
//
//            cityLocation: city,
//            workoutTypes : typeOfExercise,
//            gymPreference: gymPreferencePublished
//        )
//
//        add(newEntry: newPT, filename: "PTs.json", location: .document)
        
//        #if DEBUG
//        let usersAfterCreating: [EndUser] = load(filename: "EndUser.json", location: .document) ?? []
//        print(usersAfterCreating.count)
//        #endif
    }
}

extension PTValidationModel{
    //Name
    func validateName()-> Bool{
        if !name.isEmpty{
            error = ""
            return true
        } else {
            error = "Invalid name"
            return false
        }
        
    }
    
    func validatePhoneNum()-> Bool{
        
        if phone.isNumeric && phone.count == 10 {
            error = ""
            self.phoneNumberToStore = phone
            return true
        } else {
            error = "Invalid phone number."
            return false
        }
    }
    
    func validateEmail() -> Bool{
        if !email.isEmpty && email.isEmail {
            error = ""
            self.emailToStore = email
            return true
        } else {
            error = "Invalid email."
            return false
        }
    }
    
//    func validateGender() -> Bool{
//        if (selectedGender == "Male" || selectedGender == "Female") {
//            return true
//        } else {
//            
//        }
//    }
    
//    func validateWorkoutTypes() -> Bool{
//        
//        var validCount: Int = 0
//        for i in typesOfWorkOut {
//            if workoutTypes.contains(i) {
//                validCount += 1
//            }
//        }
//        return validCount == 3
//    }
}
