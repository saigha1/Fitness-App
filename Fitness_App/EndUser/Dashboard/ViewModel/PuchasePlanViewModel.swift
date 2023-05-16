//
//  PuchasePlanViewModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-05-16.
//

import SwiftUI

class PurchasePlanViewModel: ObservableObject{
    @Published var selectedPurchasePlan : PurchasePlan = .Workout
    
    var estimatedTax : Double{
        subTotal * 0.13
    }
    
    var Total : Double{
        subTotal + estimatedTax
    }
    
    var subTotal : Double{
        switch selectedPurchasePlan {
        case .Workout:
            return 100
        case .Diet:
            return 50
        case .Bundle:
            return 120
        }
    }
}

enum PurchasePlan : String{
    case Workout
    case Diet
    case Bundle
    
}
