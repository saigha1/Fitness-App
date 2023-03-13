//
//  NewEndUser.swift
//  Fitness_App
//
//  Created by Xavier on 2/24/23.
//

import Foundation
import SwiftUI

//MARK: EndUser Model
struct NewEndUser: Codable, Identifiable, Equatable {
    static func == (lhs: NewEndUser, rhs: NewEndUser) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    var name: String
    var profileImage: String
    var image: some View {
        profileImage.asProfileImage()
    }
    var age: Int
    //Personal Information
    var phone, email: String
    //Preferences
    var preferredTrainerGender: TrainerGender
    var gymLocation: String
    var preferredGym: PreferredGym
    var typesOfWorkOut: [WorkOutType]
    var preferredPriceRange: PriceRange
    //Health Metrics
    var heightFt: Int
    var heightIn: Double
    var skeletalMuscleMass: Double
    var currentWeight: Double
    var targetWeight: Double
    var currentBodyFat: Double
    var targetBodyFat: Double
}

enum PreferredGym: String, Codable, CaseIterable {
    case anytime = "Anytime Fitness"
    case fitForLess = "FitForLess"
    case goodLife = "GoodLife"
    case laFitness = "LA Fitness"
}

enum WorkOutType: String, Codable, CaseIterable {
    case machine = "Machine-based"
    case boxing = "Boxing"
    case lifting = "Weight-lifting"
    case calisthenics = "Calisthenics"
}

struct PriceRange: Codable {
    let currency: Currency
    let min, max: Double
}

enum Currency: String, Codable {
    case cad = "CAD"
}

enum TrainerGender: String, Codable, CaseIterable {
    case f = "Female"
    case m = "Male"
}

typealias NewEndUsers = [NewEndUser]
