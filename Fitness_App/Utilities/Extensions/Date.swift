//
//  Date.swift
//  Fitness_App
//
//  Created by Xavier on 2/9/23.
//

import Foundation

extension Date {
    
    /// An integer that represents the day of the date instance itself
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    /// An integer that represents the month of the date instance itself
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    
    /// An integer that represents the year of the date instance itself
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    /// An integer that represents the hour of the date instance itself
    var hour: Int {
        Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        Calendar.current.component(.minute, from: self)
    }
    
    /// Date Formatter - yyyy-MM
    /// - Returns: a string that represent the date instance itself, in the format of "yyyy-MM"
    ///
    /// i.e. a date 2023-02-09 09:32:10 calling this function will return "2023-02"
    func asStringYYYYMM() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: self)
    }
    
    
    func asString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    func asDayOfWeek() -> DayOfTheWeek? {
        guard let dayNum = self.dayNumberOfWeek() else { return nil}
        switch dayNum {
        case 1: return .sunday
        case 2: return .monday
        case 3: return .tuesday
        case 4: return .wednesday
        case 5: return .thursday
        case 6: return .friday
        default: return .saturday
        }
    }
}

extension Date {
    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
    
    // 0 - same day, -1 - is earlier, 1 - is later
    func isLater(than date: Date) -> Int {
        let cal = Calendar.current
        let dayComponent: Set<Calendar.Component> = [.day]
        let monthComponent: Set<Calendar.Component> = [.month]
        let yearComponent: Set<Calendar.Component> = [.year]
        
        //time
        let hourComponent: Set<Calendar.Component> = [.hour]
        let minuteComponent: Set<Calendar.Component> = [.minute]
        
        //gets the Year
        func year(_ date: Date) -> Int {
            cal.dateComponents(yearComponent, from: date).year!
        }
        //gets the Month
        func month(_ date: Date) -> Int {
            cal.dateComponents(monthComponent, from: date).month!
        }
        //gets the Day
        func day(_ date: Date) -> Int {
            cal.dateComponents(dayComponent, from: date).day!
        }
        //get hour
        func hour(_ hour: Date) -> Int {
            cal.dateComponents(hourComponent, from: date).hour!
        }
        //get minute
        func minute(_ date: Date) -> Int {
            cal.dateComponents(minuteComponent, from: date).minute!
        }
        
        let selfYear = year(self)
        let selfMonth = month(self)
        let selfDay = day(self)
        let selfHour = hour(self)
        let selfMinute = minute(self)
        
        let dateYear = year(date)
        let dateMonth = month(date)
        let dateDay = day(date)
        let dateHour = year(date)
        let dateMinute = minute(date)
        
        if selfYear > dateYear {
            return 1
        } else if selfYear < dateYear {
            return -1
        } else {
            if selfMonth > dateMonth {
                return 1
            } else if selfMonth < dateMonth {
                return -1
            } else {
                if selfDay > dateDay {
                    return 1
                } else if selfDay < dateDay {
                    return -1
                } else {
                    return 0
                }
            }
            
        
            
            
        }
    }
}


extension Date {
    func addMonth(_ month: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: month, to: self)!
    }
}
