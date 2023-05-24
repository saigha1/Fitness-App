//
//  PuchasePlanViewModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-05-16.
//

import SwiftUI

class PurchasePlanViewModel: ObservableObject{
    @Published var selectedPurchasePlan : PurchasePlan = .Workout
    @Published var selectedTypeOfWorkOut: typesOfWorkOut = .select
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

enum PurchasePlan : String, Codable {
    case Workout
    case Diet
    case Bundle
    
}

//MARK: - Payment Completion Handler
extension PurchasePlanViewModel {
    func saveTransaction(pt: PTModel, endUser: NewEndUser) {
        let transaction = Transaction(trainerUID: pt.id, endUserUID: endUser.id, subTotal: subTotal, estimatedTax: estimatedTax, total: Total, typeOfWorkOut: selectedTypeOfWorkOut, planOption: selectedPurchasePlan)
        add(newEntry: transaction, filename: "Transactions.json", location: .document)
    }
}
