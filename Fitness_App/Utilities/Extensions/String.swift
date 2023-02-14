//
//  String.swift
//  Fitness_App
//
//  Created by Xavier on 2/8/23.
//

import Foundation

extension String {
    /// Convert YYYYMMDD String to a Swift Date
    /// - Parameter dateStr: a string value that represents a date in the format: yyyyMMdd
    /// - Returns: a Swift Date that represents the date of parameter value
    ///
    /// If the string itself is not in the "yyyyMMdd" format, or the conversion fails, the current date will be returned instead.
    func yyyyMMddToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.date(from: self) ?? Date()
    }
    
    
    /// Checks if a string only contains digits and returns a bool as a result
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    
    /// Checks if a string has a valid email format and returns a bool as a result
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
