//
//  PTModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-08.
//

import Foundation
import SwiftUI

struct PTModel: Hashable, Codable{
    
    var id, name, gender, phone: String
    var email: String
    var isFeatured, isFavorite: Bool
    var description, motto, profileImg: String // Needs to change to UIImage
//    var image: some View{
//        profileImg.asProfileImage()
//    }
//
    var education : PTEducationLevel
    var certification : [certificates]
    var selectedExperience : PTexperienceLevel
    var cityLocation : gymLocation
    var workoutTypes : [typesOfWorkOut]
    var gymPreference : [gymPreferrence]
    
}

enum gymLocation : String, CaseIterable, Codable{
    case Mississauga
    case DowntownToronto = "Downtown Toronto"
    case NorthYork = "North York"
    case Ottawa
    case Other
}

enum certificates : String, CaseIterable, Codable{
    case CanFitProI = "Canadian Fitness Professionals I"
    case CanFitProII = "Canadian Fitness Professionals II"
    case CFES = "Canadian Fitness Education Services "
    case CPTN = "Certified Professional Trainers Network"
    case CSEP = "Canadian Society for Exercise Physiology "
    case FCA = "Fit Chicks Academy"
    case Other
}

enum PTEducationLevel : String, CaseIterable, Codable{
    case Diploma = "High School Diploma"
    case Bachelors = "Bachelor's"
    case Masters = "Master's"
    case Doctorate = "PhD"
    case Other
    
}

enum PTexperienceLevel : String, CaseIterable, Codable{
    case One = "Level 1"
    case Two = "Level 2"
    case Three = "Level 3"
}

enum gymPreferrence : String, CaseIterable, Codable{
    case GoodLife = "GoodLife"
    case FitnessPlanet = "Planet Fitness"
    case UFC = "UFC"
    case LAFitness = "LA Fitness"
}

enum typesOfWorkOut: String, CaseIterable, Codable{
    case calisthenic = "Calisthenic"
    case americanBoxing = "Boxing"
    case weightLifting = "weightLifting"
    case machineTraining = "Machine-Training"
}


typealias PTModels = [PTModel]
