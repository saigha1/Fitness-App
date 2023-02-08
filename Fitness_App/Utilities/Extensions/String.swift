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

}
