//
//  PTModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-08.
//

import Foundation
import SwiftUI

struct PTModel: Hashable, Codable{
    
    var id : String
    var ptProfileImage : String
    var ptImage: some View{
        ptProfileImage.asProfileImage()
        
    }
    var name, email, phone: String
    var gender : TrainerGender
    var isFeatured, isFavorite, isApproved: Bool

    
    var education : PTEducationLevel
    var certification : [certificates]
    var selectedExperience : PTexperienceLevel
    var cityLocation : gymLocation
    var gymPreference : [gymPreferrence]
    var workoutTypes : [typesOfWorkOut]
    var motto, description: String
    
   var imageString: [String]
    var computedImage : [some View]{
     var imageTemp : [AnyView] = []
        for string in imageString{
            imageTemp.append(AnyView(string.asProfileImage()))
        }
        return imageTemp
    }
    var videoUrl: [String]
    var selectedImage : String?
    var ptselfie: some View {
        Group{
            if selectedImage != nil {
                selectedImage!.asProfileImage()
            } else{
                EmptyView()
            }
        }
    }
    
    
}

enum gymLocation : String, CaseIterable, Codable{
    case select = "--select--"
    case Mississauga
    case Toronto = "Toronto"
    case NorthYork = "North York"
    case Ottawa
    case Other
}

enum certificates : String, CaseIterable, Codable{
    case select = "--select--"
    case CanFitProI = "CanFitPro I"
    case CanFitProII = "CanFitPro II"
    case CFES = "CFES"
    case CPTN = "CPTN"
    case CSEP = "CSEP"
    case FCA = "FCA"
    case Other
}

enum PTEducationLevel : String, CaseIterable, Codable{
    case select = "--select--"
    case Diploma = "Diploma"
    case Bachelors = "Bachelor's"
    case Masters = "Master's"
    case Doctorate = "PhD"
    case Other
    
}

enum PTexperienceLevel : String, CaseIterable, Codable{
    case select = "--select--"
    case One = "Level 1"
    case Two = "Level 2"
    case Three = "Level 3"
    case Other
}

enum gymPreferrence : String, CaseIterable, Codable{
    case select = "--select--"
    case GoodLife = "GoodLife"
    case FitnessPlanet = "Planet Fitness"
    case UFC = "UFC"
    case LAFitness = "LA Fitness"
    case Other
}

enum typesOfWorkOut: String, CaseIterable, Codable{
    case select = "--select--"
    case calisthenic = "Calisthenic"
    case americanBoxing = "Boxing"
    case weights = "Weights"
    case machine = "Machine"
    case Other
}


typealias PTModels = [PTModel]
