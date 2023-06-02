//
//  CalendarLegendViewEndUser.swift
//  Fitness_App
//
//  Created by Xavier on 5/25/23.
//

import SwiftUI

struct CalendarLegendViewEndUser: View {
    let screenWidth = UIScreen.main.bounds.width
    var gridItems: [GridItem]
    init() {
        self.gridItems = [.init(.fixed(screenWidth * 0.4), spacing: 10, alignment: .center), .init(.fixed(screenWidth * 0.34), spacing: 10, alignment: .center), .init(.fixed(screenWidth * 0.25), spacing: 10, alignment: .center)]
    }
    var body: some View {
            LazyVGrid(columns: gridItems) {
                Group {
                    HStack {
                        numbers
                        numberTexts
                    }
                    HStack {
                        circles
                        circleText
                    }
                    VStack {
                        HStack {
                            todayCircle
                            todayText
                        }
                        Spacer()
                    }
                }
                .padding(.leading, 30)
            }
    }
}

struct CalendarLegendViewEndUser_Previews: PreviewProvider {
    static var previews: some View {
        CalendarLegendViewEndUser()
    }
}

//MARK: - Components
extension CalendarLegendViewEndUser {
    func LengendText(_ str: String) -> some View {
        Text(str)
            .bold()
            .font(.caption)
            .frame(width: 95, alignment: .leading)
            .foregroundColor(.secondary)
    }
    private var numbers: some View {
        VStack(spacing: 15) {
            CalCellNumberView(number: 31, isBlack: false)
            CalCellNumberView(number: 1, isBlack: true)
        }
    }
    private var numberTexts: some View {
        VStack(alignment: .leading, spacing: 10) {
            LengendText("Date in Next or Previous Month")
            LengendText("Date in This Month")
        }
    }
    private var circles: some View {
        VStack(spacing: 15) {
            CalCellCircleView(isToday: false, isStroke: true)
            CalCellCircleView(isToday: false, isStroke: false)
        }
    }
    private var circleText: some View {
        VStack(alignment: .leading, spacing: 20) {
            LengendText("Past Session")
            LengendText("Upcoming Session")
        }
    }
    private var todayCircle: some View {
        CalCellCircleView(isToday: true, isStroke: true)
    }
    private var todayText: some View {
        LengendText("Today")
    }
}
