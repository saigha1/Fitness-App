//
//  GymModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-08.
//

import Foundation
//Hashable, Codable, Encodable, Decodable, Identifiable

//https://app.quicktype.io to convert JSOn to model

struct GymModel: Hashable, Codable, Identifiable{
    var id : Int
    var Brand : String //GoodLife, LAFitness, Planet Fitness
    var Site : [GymSite]
}


struct GymSite : Hashable, Codable, Identifiable{
    var Name: String
    var id: String
    var Address : AddressSite
}

struct AddressSite : Hashable, Codable{
    var StreetAdd : String
    var City : String
    var Province: String
    var PostalCode : String
    var Country : String
}
