//
//  RoundedRect.swift
//  Fitness_App
//
//  Created by Xavier on 4/18/23.
//

import SwiftUI

struct RoundedRect: View {
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(15, corners: .bottomLeft)
            .cornerRadius(15, corners: .topLeft)
            .foregroundColor(.clear)
    }
}

struct RoundedRect_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRect()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
