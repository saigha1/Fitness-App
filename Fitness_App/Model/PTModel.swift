//
//  PTModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-08.
//

import Foundation
import SwiftUI

struct PTModel: Hashable, Codable{
    
    var id, name, phone: String
    var email: String
    var isFeatured, isFavorite: Bool
     // Needs to change to UIImage
//    var image: some View{
//        profileImg.asProfileImage()
//    }
    var gender : TrainerGender
    var education : PTEducationLevel
    var certification : [certificates]
    var selectedExperience : PTexperienceLevel
    var cityLocation : gymLocation
    var workoutTypes : [typesOfWorkOut]
    var gymPreference : [gymPreferrence]
    var description, motto, profileImg: String
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
}

enum gymPreferrence : String, CaseIterable, Codable{
    case select = "--select--"
    case GoodLife = "GoodLife"
    case FitnessPlanet = "Planet Fitness"
    case UFC = "UFC"
    case LAFitness = "LA Fitness"
}

enum typesOfWorkOut: String, CaseIterable, Codable{
    case select = "--select--"
    case calisthenic = "Calisthenic"
    case americanBoxing = "Boxing"
    case weights = "Weights"
    case machine = "Machine"
}


typealias PTModels = [PTModel]
