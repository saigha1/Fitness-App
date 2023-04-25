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
    @Published var selectedLength: Int = 1
    @Published var selectedGym : gymPreferrence = .select
    // View Controller
    @Published var showTransactionSummary: Bool = false
    // Data for transaction summary
    func getNoOfSessions() -> Int {
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
    func getNoOfHours() -> Double {
        let timeInterval = (selectedEndTime.timeIntervalSince(selectedStartTime))
        return (Double(getNoOfSessions()) * timeInterval / 3600 / 0.25).rounded() * 0.25
    }
}
