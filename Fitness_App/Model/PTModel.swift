//
//  PTModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-08.
//

import Foundation
import SwiftUI

struct PTModel: Hashable, Codable{

    var name : String
    var phone : Int
    var email : String
    var gymLocation : String                  //Get location using Google's API User Location
    
    enum preferredGym : String{
        case GoodLife = "GoodLife"
        case FitnessPlanet = "Planet Fitness"
        case UFC = "UFC"
        case LAFitness = "LA Fitness"
    }
            
    enum typesOfWorkOut: String{
        case Calisthenic = "Calisthenic"
        case WeightTraining = "Weight Training"
        case Boxing = "Boxing"
        case General = "General"
    }
    
    
}
