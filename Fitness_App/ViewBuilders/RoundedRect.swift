//
//  RoundedRect.swift
//  Fitness_App
//
//  Created by Xavier on 4/18/23.
//

import SwiftUI

struct RoundedRect: View {
    @Binding var isSelected : Bool
    var width : CGFloat = 50
    var height : CGFloat = 50
    var cornerRadius : CGFloat = 15
    var corners : [UIRectCorner] = []
    
    
    func makeRect(_ inner : Bool = false) -> some View {
        Rectangle()
            .fill(inner ? (isSelected ? Color.assetColor.cyan : Color.assetColor.white) : Color.black)
            .frame(width: inner ? width*0.96 : width, height: inner ? height * 0.96 : height)
    }
    
    var sunday: some View {
        ZStack{
            makeRect()
                .cornerRadius(15, corners: .topLeft)
                .cornerRadius(15, corners: .bottomLeft)
            
            makeRect(true)
                .cornerRadius(15, corners: .topLeft)
                .cornerRadius(15, corners: .bottomLeft)
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
    
    var saturday: some View {
        ZStack{
            makeRect()
                .cornerRadius(15, corners: .topRight)
                .cornerRadius(15, corners: .bottomRight)
            
            makeRect(true)
                .cornerRadius(15, corners: .topRight)
                .cornerRadius(15, corners: .bottomRight)
        }
    }
    
    var weekDay: some View {
        ZStack{
            makeRect()
           
            makeRect(true)
        }
    }
    var body: some View{
        sunday
    }
    
    
}

struct RoundedRect_Previews: PreviewProvider {
//    static var isSelected : Bool = false
    static var previews: some View {
//        RoundedRect(isSelected: .init(get: {
//            isSelected
//        }, set: { newValue in
//            isSelected = newValue
//        }))
        TestRoundedRect()
    }
}

struct TestRoundedRect :  View{
    @State var isSelected : Bool = false
    var body: some View{
        HStack{
            ForEach(dayOfTheWeek.allCases, id: \.rawValue){day in
                ZStack{
//                    switch day{
//                    case .sunday : RoundedRect()
//                    case .saturday : RoundedRect()
//                    default : RoundedRect()
//                    }
                    
                    Text(String(day.rawValue.first!))
                }
                
            }
        }
    }
    enum dayOfTheWeek :  String, CaseIterable{
        case sunday = "S"
        case monday = "M"
        case tuesday = "T"
        case wednesday = "W"
        case thursday = "Thur"
        case friday = "F"
        case saturday = "Sat"
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
