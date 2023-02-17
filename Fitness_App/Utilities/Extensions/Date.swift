//
//  Date.swift
//  Fitness_App
//
//  Created by Xavier on 2/9/23.
//

import Foundation

extension Date {
    
    /// An integer that represents the month of the date instance itself
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    /// An integer that represents the year of the date instance itself
    var year: Int {
        Calendar.current.component(.year, from: self)
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
