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
    /// - Returns: return a SwiftUI of an image or a placerholder or a progress view while loading
    func asProfileImage(_ size: CGFloat = 15, padding: CGFloat? = 15) -> some View {
        self.toView { image in
            image
                .frame(width: size, height: size)
                .scaledToFill()
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(lineWidth: 1)
                        .foregroundColor(.secondary.opacity(0.8))
                        .frame(width: size, height: size)
                )
                .padding(padding ?? 0)
        }
    }
    /// Converts a string to UIImage
    /// - Returns: a UIImage that the string represents or a placeholder of the person.circle icon
    func asUIImage() -> UIImage{
//        let str = self.replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
        let placeholder = UIImage(systemName: "person.circle")!
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return placeholder
        }
        return UIImage(data: imageData) ?? placeholder
    }
}

extension String {
    func toView(@ViewBuilder config: @escaping (_ image: AnyView) -> some View) -> some View {
        let fromDataString = AsyncImage(
            url: URL(string: "data:image/jpeg;base64," + self),
            content: { image in
                config(AnyView(image.resizable()))
            },
            placeholder: {
                config(AnyView(ProgressView()))
            }
        )
        return AsyncImage(
            url: URL(string: self),
            content: { image in
                config(AnyView(image.resizable()))
            },
            placeholder: { fromDataString }
        )
    }
}
