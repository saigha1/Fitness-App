//
//  Double.swift
//  Fitness_App
//
//  Created by Xavier on 2/8/23.
//

import Foundation

extension Double {
    
    /// Convert Double with 2 decimal places
    /// - Returns: a string that represents the double value with 2 decimal places
    func asStringWith2Decimals() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert Double to Percentage
    /// /// - Returns: a string that represents the double value with 2 decimal places, as a percentage
    func asPercentageStringWith2Decimals() -> String {
        return (self*100).asStringWith2Decimals() + "%"
    }
}
