//
//  String.swift
//  Fitness_App
//
//  Created by Xavier on 2/8/23.
//

import Foundation
import SwiftUI
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
    
    
    /// Parse a string and convert it to an image view
    /// - Parameters:
    ///   - size: CGFloat - the width and height of the view. Its default value is 15.
    ///   - padding: CGFloat? - the horizontal and vertical padding of the view. Its default value is 15
    /// - Returns: return a SwiftUI of an image or a placerholder (􀉩) or a progress view (􀅈) while loading
    func asProfileImage(_ size: CGFloat = 15, padding: CGFloat? = 15) -> some View {
        AsyncImage(url: URL(string: self)) { image in
            image
                .resizable()
                .clipShape(Circle())
        } placeholder: {
            Group {
                if self.isEmpty { Image(systemName: "person")
                        .resizable()
                        .frame(width: size * 0.7, height: size * 0.7)
                        .foregroundColor(.secondary)
                    
                } else {
                    ProgressView()
                }
            }
                .overlay(
                    Circle().stroke(lineWidth: 1)
                        .foregroundColor(.secondary.opacity(0.8))
                        .frame(width: size, height: size)
                )
        }
        .frame(width: size, height: size)
        .padding(padding ?? 1)
    }
}
