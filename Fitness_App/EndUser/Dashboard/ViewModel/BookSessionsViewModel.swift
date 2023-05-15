//
//  BookSessionsViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 4/20/23.
//

import Foundation

class BookSessionsViewModel: ObservableObject {
    // Fields inputs or states
    @Published var selectedDays: [DayOfTheWeek] = []
    @Published var selectedStartDate: Date = Date()
    @Published var selectedStartTime: Date = Date()
    @Published var selectedEndTime: Date = Date() + 3600
    @Published var selectedLength: Int = 0
    @Published var selectedGym : gymPreferrence = .select
    @Published var errorMsg : String = ""
    let ratePerHour = 15.0

    // View Controller
    @Published var showTransactionSummary: Bool = false
    
    func buttonValidation(){
        
        guard selectedDays.count > 0 else {
            errorMsg = "Please schedule your days of training"
            showTransactionSummary = false
            return }
        
        //selectedStartDate = Time BookSessions was loaded
        guard selectedStartDate > Date() || selectedStartDate.isInSameDay(as: Date()) else {
            errorMsg = "Please ensure start date is today or after."
            showTransactionSummary = false
            return }
        if selectedStartDate.isInSameDay(as: Date()) {
            guard selectedStartTime > Date() else {
                errorMsg = "Please ensure start-time is after current time"
                showTransactionSummary = false
                return }
        }
        guard selectedStartTime < selectedEndTime else {
            errorMsg = "Please ensure end-time is after start-time"
            showTransactionSummary = false
            return }
        
        guard selectedLength != 0 else {
            errorMsg = "Please make a length selection"
            showTransactionSummary = false
            return
            
        }
        
        guard selectedGym != .select else {
            errorMsg = "Please make a gym selection"
            showTransactionSummary = false
            return }
        
        errorMsg = ""
        showTransactionSummary = true

    }
    
    // Data for transaction summary
    var NoOfSessions : Int {
        // Get Start Date and End Date
        var startDate = selectedStartDate
        let length = DateComponents(month: selectedLength)
        guard let endDate = Calendar.current.date(byAdding: length, to: startDate) else { return 0 }
        
        // While loop: calcuate number of sessions
        // when a day has the same "day of the week" the picker contains, increase # of sessions
        var numberOfSessions = 0
        while startDate < endDate {
            let dayOfWeek = startDate.asDayOfWeek()!
            if selectedDays.contains(dayOfWeek) {
                numberOfSessions += 1
            }
            // increase start date by one day
            startDate = Calendar.current.date(byAdding: DateComponents(day: 1), to: startDate)!
        }
        return numberOfSessions
    }
    var NoOfHours: Double {
        let timeInterval = (selectedEndTime.timeIntervalSince(selectedStartTime))
        return (Double(NoOfSessions) * timeInterval / 3600 / 0.25).rounded() * 0.25
    }
    
    var grandTotal : Double {
        NoOfHours * ratePerHour
    }
    
    var subTotal : Double{
        grandTotal - ratePerHour
    }
    
    var estimatedTax : Double{
        subTotal * 0.13
    }
    
    var total : Double{
        subTotal + estimatedTax
    }
    
    
}
