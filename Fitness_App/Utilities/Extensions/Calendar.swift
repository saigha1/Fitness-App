//
//  Calendar.swift
//  Fitness_App
//
//  Created by MAC on 2023-05-24.
//

import Foundation


extension Calendar {
    // get all dates of a month
    func getAllDates(
        dateInterval: DateInterval,
        dateComponent: DateComponents) -> [Date] {
        
        var dates: [Date] = []
        dates.append(dateInterval.start)
        
        enumerateDates(startingAfter: dateInterval.start, matching: dateComponent, matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date else {
                return
            }
            
            if date < dateInterval.end { dates.append(date) } else {
                stop = true //inout
            }
        }
        return dates
    }
    
    // get all dates of a month + ending days from last month + startings days from next month + another week if the result is less than 6 weeks
    func getAllRealDays(for month: Date) -> [Date] {
        var results: [Date] = []
        guard
            let monthInterval = self.dateInterval(of: .month, for: month),
            let monthFirstWeek = self.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = self.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return results }
        results += self.getAllDates(
            dateInterval: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            dateComponent: DateComponents(hour: 0, minute: 0, second: 0)
        )
        if results.count < 42 {
            let endOfNextWeek = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: monthLastWeek.end)!
            results += self.getAllDates(dateInterval: .init(start: monthLastWeek.end, end: endOfNextWeek), dateComponent: DateComponents(hour: 0, minute: 0, second: 0))
        }
        return results
    }
}
