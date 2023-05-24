//
//  CalendarViewModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-05-24.
//

import Foundation

class CalendarViewModel: ObservableObject {
    
    @Published var month: Int = 1
    @Published var year: Int = 1999
    
    var datesWithSessions : [Date] {
        var results : [Date] = []
        let transactions : [Transaction] = load(filename: "Transactions.json", location: .document) ?? []
        
        for transaction in transactions {
            guard let length = transaction.length else { return results }
            guard let startDate = transaction.startDate else { return results }
            guard let weekDays = transaction.weekDays else { return results }
            let endDate = startDate.addMonth(length)
            
            let dates = Calendar.current.getAllDates(
                dateInterval: DateInterval(start: startDate, end: endDate),
                dateComponent: DateComponents(hour: 0, minute: 0, second: 0)
            )
            
            for date in dates{
                guard let weekday = date.asDayOfWeek() else { return results }
                
                if weekDays.contains(weekday){
                    results.append(date)
                }
            }
        }
        return results
    }
    
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    // load current year and month
    func showToday() {
        year = calendar.component(.year, from: Date())
        month = calendar.component(.month, from: Date())
    }
    func getCalendarDays() -> [Date] {
        let startDate = calendar.date(from: DateComponents(year: year, month: month))!
        return calendar.getAllRealDays(for: startDate)
    }
    func isCurrentMonth(date: Date) -> Bool {
        let components = calendar.dateComponents([.year, .month], from: date)
        return components.month == month && components.year == year
    }
    
    func prevMonth(){
        if month == 1 {
            month = 12
            year -= 1
        } else {
            month -= 1
        }
    }
    
    func nextMonth(){
        if month == 12 {
            month = 1
            year += 1
        } else {
            month += 1
        }
    }
    
}
