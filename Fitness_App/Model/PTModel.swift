//
//  PTModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-08.
//

import Foundation

struct PTModel: Hashable, Codable{

    var name : String
    var gender: String
    var phone : String
    var email : String
    var experienceLevel : String
    var education : String
    var Certification : String
    var gymLocation : preferredGym
    var workoutTypes : typesOfWorkOut
    var Description : String
    var Motto : String
    var PreferredGym: String
    
    enum preferredGym : String, Identifiable, CaseIterable, Codable{
        case GoodLife = "GoodLife"
        case FitnessPlanet = "Planet Fitness"
        case UFC = "UFC"
        case LAFitness = "LA Fitness"
        var id : String {rawValue}
    }
            
    enum typesOfWorkOut: String, Codable{
        case Calisthenic = "Calisthenic"
        case WeightTraining = "Weight Training"
        case Boxing = "Boxing"
        case General = "General"
    }
    
    
}
