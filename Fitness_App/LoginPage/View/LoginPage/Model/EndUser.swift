//
//  EndUser.swift
//  Fitness_App
//
//  Created by Xavier on 2/9/23.
//

import Foundation
import SwiftUI

struct EndUser: Codable {
    var id: String // UUID string
    //personal info
    var name: String
    var profileImageName: String?
    var profileImage: Image {
        Image(profileImageName ?? "")
    }
    var age: Int
    var phone: String
    var email: String
    //preferences
    var preferredTrainerGender: String
    var gymLocation: String
    var typesOfWorkOut: [String]
    var preferredPriceRange: PriceRangePrefrence
    //health metrics
    var heightFt: Int
    var heightIn: Double
    var skeletalMuscleMass: Double
    var currentWeight: Double
    var targetWeight: Double
    var currentBodyFat: Double
    var targetBodyFat: Double
}

struct PriceRangePrefrence: Codable {
    var currency: String
    var min: Double
    var max: Double
}

//TODO: Replace with data from JSON
let userIDMichaelLogan = "a7a3c754-e154-4e15-bbab-2cbc03d2fe19"
//let user = EndUser(
//    id: userIDMichaelLogan,
//    name: "Michael Logan",
//    profileImageName: "User Profile Image",
//    age: 23,
//    phone: "437-123-1234",
//    email: "mlogan2000@icloud.com",
//    preferredTrainerGender: "Male",
//    gymLocation: "Etobicoke, ON",
//    typesOfWorkOut: [
//        "Machine-based",
//        "Weight-Lifting",
//        "Boxing"
//    ],
//    preferredPriceRange: PriceRangePrefrence(
//        currency: "CAD",
//        min: 400,
//        max: 700),
//    heightFt: 5,
//    heightIn: 10,
//    skeletalMuscleMass: 83.3,
//    currentWeight: 177,
//    targetWeight: 157,
//    currentBodyFat: 0.22,
//    targetBodyFat: 0.18
//)
