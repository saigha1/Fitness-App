//
//  PTValidationModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-03-03.
//

import Foundation
import UIKit

class PTValidationModel: ObservableObject {
    
    // State string for the error message
    @Published var error: String = ""
    //State properties for fields
    @Published var profIMG : [String] = [""]
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var gender : TrainerGender = .select
    @Published var education: PTEducationLevel = .select
    @Published var certificate: [certificates] = [.select,.select]
    @Published var experienceLevel : PTexperienceLevel = .select
    @Published var city : gymLocation = .select
    @Published var gymPreferencePublished : [gymPreferrence] = [.select, .select, .select]
    @Published var typeOfExercise: [typesOfWorkOut] = [.select, .select, .select]
    @Published var motto: String = ""
    @Published var description: String = ""
    
    @Published var inputImage: [UIImage] = []
    @Published var videoURL: [String] = []
    @Published var selectedImage: UIImage?
    
    @Published var selectedImageBool : Bool = false
    var nameToStore: Int = 0
    
    //For features
    @Published var isFeaturedToStore: Bool = false
    @Published var isFavoriteToStore: Bool = false
    @Published var ptApproved: Bool = false

    
    
    func workoutTypesSelectable(_ index: Int) -> [typesOfWorkOut]{
        let workoutTypes = typesOfWorkOut.allCases
        return [typeOfExercise[index]] +
        workoutTypes.filter { type in
            !typeOfExercise.contains(type)
        }
    }
    
    func populateStates(_ user: PTModel) {
        name = user.name
        email = user.email
        profIMG[0] = user.ptProfileImage
        phone = user.phone
        gender = user.gender
        education = user.education
        certificate = user.certification
        experienceLevel = user.selectedExperience
        city = user.cityLocation
        gymPreferencePublished = user.gymPreference
        typeOfExercise = user.workoutTypes
        motto = user.motto
        description = user.description
        inputImage = {
            var tempArray: [UIImage] = []
            for IMG in user.imageString {
                tempArray.append(IMG.asUIImage())
            }
            return tempArray
        }()
        videoURL = user.videoUrl
        selectedImage = (user.selectedImage ?? "").asUIImage()
    }
    
    func validateForm(_ firebaseUID: String) -> Bool{
        // check if all validation functions returns true
        guard validateName() else { return false}
        guard validatePhoneNum() else { return false }
        guard validateEmail() else { return false }
        guard validateGender() else { return false}
        guard validateEducation() else { return false}
        guard validateCertificate() else { return false }
        guard validateExperienceLevel() else { return false }
        guard validateCity() else { return false}
        guard validateGymPreferrence() else { return false }
        guard validateExerciseType() else { return false}
        guard validateMotto() else { return false}
        guard validateDescription() else { return false}
        guard validateImage() else { return false}
        guard validateVideo() else { return false}
//        guard validateSelfie() else { return } TODO: Uncomment later.

        let ptBeforeUpdating: [PTModel] = load(filename: "PTs.json", location: .document) ?? []
        

        // create new user and save to JSON in .document directory
        var imageString : [String] = []
        
        for image in inputImage{
            // Changed to jpeg data to compress data size
            if let imageData = image.jpegData(compressionQuality: 0.09) {imageString.append(imageData.base64EncodedString())}
            else{
                imageString.append(image.jpegData(compressionQuality: 1.0)?.base64EncodedString() ?? "")
            }
        }
        
        //picture from camera
        var selfieString : String = ""
//            guard let image = selectedImage else { return }
//
//            // Changed to jpeg data to compress data size
//            guard let imageData = image.jpegData(compressionQuality: 0.09) else { return }
//            selfieString = "data:image/jpeg;base64," + imageData.base64EncodedString()
        
        print("Creating a new PT")
        
        let newPT = PTModel(
            id: firebaseUID,
            ptProfileImage: profIMG[0],
            name: name,
            email: email,
            phone: phone,
            gender: gender,
            isFeatured: isFeaturedToStore,
            isFavorite: isFavoriteToStore,
            isApproved: ptApproved,
            
            education: education,
            certification: certificate,
            selectedExperience: experienceLevel,
            cityLocation: city,
            gymPreference: gymPreferencePublished,
            workoutTypes : typeOfExercise,
            motto: motto,
            description: description,
            imageString: imageString,
            videoUrl: videoURL,
            selectedImage: selfieString
        )
        if  let ptFound = ptBeforeUpdating.first(where: { PT in
            PT.id == firebaseUID
            
        }){
            update(old: ptFound, new: newPT, filename: "PTs.json", location: .document)
        }
        else {
            add(newEntry: newPT, filename: "PTs.json", location: .document)
        }
        
        #if DEBUG
        let usersAfterCreating: [PTModel] = load(filename: "PTs.json", location: .document) ?? []
        print(usersAfterCreating.count)
        #endif
        //TODO: Not working... or currentPTUser
        ptApproved = true
        return true
        
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
            return true
        } else {
            error = "Invalid phone number."
            return false
        }
    }

    func validateEmail() -> Bool{
        if !email.isEmpty && email.isEmail {
            error = ""
            return true
        } else {
            error = "Invalid email."
            return false
        }
    }
    
    func validateGender() -> Bool{
        if (gender != .select) {
            error = ""
            return true
        } else {
            error = "Please select a gender"
            return false
        }
    }
        
    func validateCity() -> Bool{
        if (city != .select) {
            error = ""
            return true
        } else {
            error = "Please enter your city location"
            return false
        }
    }
    
    func validateGymPreferrence() -> Bool{
        if (gymPreferencePublished[0] != .select) {
            error = ""
            return true
        } else {
            error = "Please make a gym #1 selection"
            return false
        }
    }
    
    func validateExerciseType() -> Bool{
        if (typeOfExercise[0] != .select) {
            error = ""
            return true
        } else {
            error = "Please make a gym #1 selection"
            return false
        }
    }
    
    func validateEducation() -> Bool{
        if (education != .select) {
            error = ""
            return true
        } else {
            error = "Please enter your highest level education completed"
            return false
        }
    }
    
    func validateCertificate() -> Bool{
        if (certificate[0] != .select) {
            error = ""
            return true
        } else {
            error = "Please make a certficate selection."
            return false
        }
    }
    
    func validateExperienceLevel() -> Bool{
        if (experienceLevel != .select) {
            error = ""
            return true
        } else {
            error = "Please select an experience level."
            return false
        }
    }
    
    func validateMotto()-> Bool{
        if !motto.isEmpty{
            error = ""
            return true
        } else {
            error = "Please enter a Motto."
            return false
        }
    }
    
    func validateDescription()-> Bool{
        if !description.isEmpty{
            error = ""
            return true
        } else {
            error = "Please enter a desription about you."
            return false
        }
    }
    
    func validateImage()-> Bool{
        if inputImage.count != 0 &&  inputImage.count < 4{
            error = ""
            return true
        } else {
            error = "Please select 3 photos."
            return false
        }
    }
    
    func validateVideo()-> Bool{
        if videoURL.count != 0 {
            error = ""
            return true
        } else {
            error = "Please select 1 videos."
            return false
        }
    }
    
    func validateSelfie()-> Bool{
        if selectedImage != nil{
            error = ""
            return true
        } else {
            error = "Please upload a selfie"
            return false
        }
    }

}
