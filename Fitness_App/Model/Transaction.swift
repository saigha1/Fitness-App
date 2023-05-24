//
//  Transaction.swift
//  Fitness_App
//
//  Created by Xavier on 5/17/23.
//

import Foundation

struct Transaction: Codable {
    //Transaction Details
    let isPlan: Bool
    let transactionID: String
    let trainerUID: String
    let endUserUID: String
    let subTotal: Double
    let estimatedTax: Double
    let total: Double
    let transTime: Date
    
    // Book Sessions Transactions
    //Session Details
    let weekDays: [DayOfTheWeek]?
    let startDate: Date?
    let startTime: Date?
    let endTime: Date?
    let length: Int?
    let location: gymLocation?
    let gymBrand: gymPreferrence?
    let numOfSessions: Int?
    let numOfHrs: Double?
    let grandTotal: Double?
    let bonus: Double?
    
    // Purchase Plans Transactions
    let typeOfWorkOut: typesOfWorkOut?
    let planOption: PurchasePlan?
    
    // Book Sessions Init
    init(trainerUID: String, endUserUID: String, subTotal: Double, estimatedTax: Double, total: Double, dates: [DayOfTheWeek]?, startDate: Date?, startTime: Date?, endTime: Date?, length: Int?, location: gymLocation?, gymBrand: gymPreferrence?, numOfSessions: Int?, numOfHrs: Double?, grandTotal: Double?, bonus: Double?) {
        self.isPlan = false
        self.transactionID = UUID().uuidString
        self.trainerUID = trainerUID
        self.endUserUID = endUserUID
        self.subTotal = subTotal
        self.estimatedTax = estimatedTax
        self.total = total
        self.transTime = Date()
        self.weekDays = dates
        self.startDate = startDate
        self.startTime = startTime
        self.endTime = endTime
        self.length = length
        self.location = location
        self.gymBrand = gymBrand
        self.numOfSessions = numOfSessions
        self.numOfHrs = numOfHrs
        self.grandTotal = grandTotal
        self.bonus = bonus
        self.typeOfWorkOut = nil
        self.planOption = nil
    }
    
    // Purchase Plans Init
    init(trainerUID: String, endUserUID: String, subTotal: Double, estimatedTax: Double, total: Double, typeOfWorkOut: typesOfWorkOut?, planOption: PurchasePlan?) {
        self.isPlan = true
        self.transactionID = UUID().uuidString
        self.trainerUID = trainerUID
        self.endUserUID = endUserUID
        self.subTotal = subTotal
        self.estimatedTax = estimatedTax
        self.total = total
        self.transTime = Date()
        self.weekDays = nil
        self.startDate = nil
        self.startTime = nil
        self.endTime = nil
        self.length = nil
        self.location = nil
        self.gymBrand = nil
        self.numOfSessions = nil
        self.numOfHrs = nil
        self.grandTotal = nil
        self.bonus = nil
        self.typeOfWorkOut = typeOfWorkOut
        self.planOption = planOption
    }
}
