//
//  EndUserModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-07.
//API Key for Google MAPS SDK: AIzaSyArNQo7RSOaCpOEJDiHfjhbPhoQXkp_aq8

import Foundation

struct EndUserModel: Hashable, Codable, Identifiable{
    
    var id: Int
    var name : String?
    var phone : Int?
    var email : String?
    var preferredTrainerGender : String
    var gymLocation : String  //Get location using Google's API User Location
    
    enum preferredGym : String{
        //A list of locations within a radius from a user's location
        case GoodLife = "GoodLife-SquareOne"
        case FitnessPlanet = "Planet Fitness-Meadowvale"
    }
    
    enum typesOfWorkOut: String{
        case Calisthenic = "Calisthenic"
        case WeightTraining = "Weight Training"
        case Boxing = "Boxing"
        case General = "General"
        }
    
    struct preferredPriceRange{
        var currency: String
        var minimum: Int
        var maximum: Int
    }

}


