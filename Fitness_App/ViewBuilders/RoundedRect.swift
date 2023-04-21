//
//  RoundedRect.swift
//  Fitness_App
//
//  Created by Xavier on 4/18/23.
//

import SwiftUI

//MARK: - A Rectangle with two or no corner radius as Day of the Week Picker Cell
struct RoundedRect: View {
    @Binding var isSelected : Bool
    var day: DayOfTheWeek
    var size : CGFloat = 20
    var cornerRadius : CGFloat = 5
    var corners : [UIRectCorner] = []
    
    func makeRect(_ inner : Bool = false) -> some View {
        Rectangle()
            .fill(inner ? (isSelected ? Color.assetColor.cyan : Color.assetColor.white) : Color.black)
            .frame(width: inner ? size * 0.96 : size, height: inner ? size * 0.96 : size)
    }
    
    var sunday: some View {
        ZStack{
            makeRect()
                .cornerRadius(cornerRadius, corners: .topLeft)
                .cornerRadius(cornerRadius, corners: .bottomLeft)
            
            makeRect(true)
                .cornerRadius(cornerRadius, corners: .topLeft)
                .cornerRadius(cornerRadius, corners: .bottomLeft)
        }
    }
    
    var saturday: some View {
        ZStack{
            makeRect()
                .cornerRadius(cornerRadius, corners: .topRight)
                .cornerRadius(cornerRadius, corners: .bottomRight)
            
            makeRect(true)
                .cornerRadius(cornerRadius, corners: .topRight)
                .cornerRadius(cornerRadius, corners: .bottomRight)
        }
    }
    
    var weekDay: some View {
        ZStack{
            makeRect()
           
            makeRect(true)
        }
    }
    var body: some View {
        Group {
            switch day {
            case .sunday: sunday
            case .saturday: saturday
            default: weekDay
            }
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct RoundedRect_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DatePickerCell()
            RoundedRect(isSelected: .constant(true), day: .sunday)
            RoundedRect(isSelected: .constant(false), day: .friday)
            RoundedRect(isSelected: .constant(true), day: .saturday)
        }
    }
}

//MARK: - A View modifer that applies corner radius to a specific corner of a frame
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
struct DatePickerCell: View {
    private var cell: some View {
        Path() { p in
            p.move(to: CGPoint(x: 60, y: 60))
            p.addQuadCurve(to: .init(x: 120, y: 120), control: .init(x: 60, y: 120))
            p.addLine(to: .init(x: 120 + 120, y: 120))
            p.addQuadCurve(to: .init(x: 300, y: 60), control: .init(x: 300, y: 120))
            p.addLine(to: .init(x: 300, y: -60))
            p.addQuadCurve(to: .init(x: 240, y: -120), control: .init(x: 300, y: -120))
            p.addLine(to: .init(x: 120, y: -120))
            p.addQuadCurve(to: .init(x: 60, y: -60), control: .init(x: 60, y: -120))
            p.addLine(to: .init(x: 60, y: 60))
        }
        .stroke(lineWidth: 3)
        .padding(.top, 150)
    }
    
    var weekDay: some View {
        Path() { p in
            p.move(to: .init(x: 60, y: 60))
            p.addLine(to: .init(x: 60, y: 120))
            p.addLine(to: .init(x: 60 + 120 + 60, y: 120))
            p.addLine(to: .init(x: 60 + 120 + 60, y: 120 - 120 - 60))
            p.addLine(to: .init(x: 60, y: -60))
            p.addLine(to: .init(x: 60, y: -60+120))
        }
        .stroke(lineWidth: 3)
        .padding(.top, 150)
    }
    var sunday: some View {
        Path() { p in
            p.move(to: CGPoint(x: 60, y: 60))
            p.addQuadCurve(to: .init(x: 120, y: 120), control: .init(x: 60, y: 120))
            p.addLine(to: .init(x: 120 + 120 + 60, y: 120))
            p.addLine(to: .init(x: 300, y: -120))
            p.addLine(to: .init(x: 120, y: -120))
            p.addQuadCurve(to: .init(x: 60, y: -60), control: .init(x: 60, y: -120))
            p.addLine(to: .init(x: 60, y: 60))
        }
        .stroke(lineWidth: 3)
        .padding(.top, 150)
    }
    var satudary: some View {
        Path() { p in
            p.move(to: CGPoint(x: 60, y: 60))
            p.addLine(to: .init(x: 60, y: 120))
            p.addLine(to: .init(x: 120 + 120, y: 120))
            p.addQuadCurve(to: .init(x: 300, y: 60), control: .init(x: 300, y: 120))
            p.addLine(to: .init(x: 300, y: -60))
            p.addQuadCurve(to: .init(x: 240, y: -120), control: .init(x: 300, y: -120))
            p.addLine(to: .init(x: 60, y: -120))
            p.addLine(to: .init(x: 60, y: 60))
        }
        .stroke(lineWidth: 3)
        .padding(.top, 150)
    }
    var body: some View {
        satudary
    }
}
