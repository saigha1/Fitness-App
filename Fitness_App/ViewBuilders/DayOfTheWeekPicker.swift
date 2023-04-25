//
//  DayOfTheWeekPicker.swift
//  Fitness_App
//
//  Created by Xavier on 4/20/23.
//

import SwiftUI

struct DayOfTheWeekPicker :  View{
    @Binding var selectedDays : [DayOfTheWeek]
    var size: CGFloat = 25
    var body: some View{
        HStack{
            ForEach(DayOfTheWeek.allCases, id: \.rawValue){day in
                ZStack{
                    RoundedRect(isSelected: .init(get: {
                        selectedDays.contains(day)
                    }, set: { newVal in
                        if newVal && !selectedDays.contains(day) {
                            selectedDays.append(day)
                        }
                        if !newVal && selectedDays.contains(day) {
                            selectedDays.removeAll { $0 == day }
                        }
                        print(selectedDays)
                    }), day: day, size: size)
                    Text(String(day.rawValue.first!)).bold()
                        .font(.system(size: size / 2))
                }
            }
        }
    }
}
