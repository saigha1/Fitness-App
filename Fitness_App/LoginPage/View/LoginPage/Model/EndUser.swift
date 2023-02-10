//
//  EndUser.swift
//  Fitness_App
//
//  Created by Xavier on 2/9/23.
//

import Foundation
import SwiftUI

struct EndUser {
    var id: UUID
    //personal info
    var name: String
    var profileImageName: String
    var profileImage: Image {
        Image(profileImageName)
    }
    var age: Int
    var phoneNum: String
    var email: String
    //preferences
    var preferredPTGender: String
    var gymLocation: String
    var typesOfWorkout: [String]
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

struct PriceRangePrefrence {
    var currencyCode: String
    var min: Double
    var max: Double
}

//TODO: Replace with data from JSON
let userIDMichaelLogan = UUID(uuidString: "a7a3c754-e154-4e15-bbab-2cbc03d2fe19") ?? UUID()
let user = EndUser(
    id: userIDMichaelLogan,
    name: "Michael Logan",
    profileImageName: "User Profile Image",
    age: 23,
    phoneNum: "437-123-1234",
    email: "mlogan2000@icloud.com",
    preferredPTGender: "Male",
    gymLocation: "Etobicoke, ON",
    typesOfWorkout: [
        "Machine-based",
        "Weight-Lifting",
        "Boxing"
    ],
    preferredPriceRange: PriceRangePrefrence(
        currencyCode: "CAD",
        min: 400,
        max: 700),
    heightFt: 5,
    heightIn: 10,
    skeletalMuscleMass: 83.3,
    currentWeight: 177,
    targetWeight: 157,
    currentBodyFat: 0.22,
    targetBodyFat: 0.18
)
