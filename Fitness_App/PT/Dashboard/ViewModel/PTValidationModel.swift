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
    @Published var experienceLevel = ""
    @Published var education: String = ""
    @Published var Certification: String = ""
    @Published var gymLocation: String = ""
    @Published var typeOfWorkOut: [PTModel.typesOfWorkOut] = [workoutTypes[0], workoutTypes[1], workoutTypes[2]]
    @Published var Description: String = ""
    @Published var Motto: String = ""
    
    var nameToStore: Int = 0
    
    var ageToStore: Int = 0
    var phoneNumberToStore: String = ""
    var emailToStore: String = ""
    
    var trainersGenderToStore: String = ""
    var gymLocationToStore: String = ""
//    var typeOfWorkoutToStore: [String] = []
    
    func validateForm() {
        // check if all validation functions returns true
        guard validateName() else { return }
//        guard validateAge() else { return }
        guard validatePhoneNum() else { return }
        guard validateEmail() else { return }
        guard validateWorkoutTypes() else { return }

        #if DEBUG
        let usersBeforeCreating: [EndUser] = load(filename: "EndUser.json", location: .document) ?? []
        print(usersBeforeCreating.count)
        #endif
        
        // create new user and save to JSON in .document directory
        let newPT = PTModel(
            id: UUID().uuidString,
            name: name,
            gender: trainersGenderToStore,
            phone: phoneNumberToStore,
            email: emailToStore,
            experienceLevel: experienceLevel,
            education: education,
            Certification: Certification,
            gymLocation: ,
            workoutTypes: typeOfWorkoutToStore,
            Description: Description,
            Motto: Motto,
            PreferredGym: <#String#>
            
        )
        add(newEntry: newUser, filename: "EndUser.json", location: .document)
        
        #if DEBUG
        let usersAfterCreating: [EndUser] = load(filename: "EndUser.json", location: .document) ?? []
        print(usersAfterCreating.count)
        #endif
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
    
    func validateWorkoutTypes() -> Bool{
        
        var validCount: Int = 0
        for i in typeOfWorkOut {
            if workoutTypes.contains(i) {
                validCount += 1
            }
        }
        return validCount == 3
    }
}
