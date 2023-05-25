//
//  CalendarView.swift
//  Fitness_App
//
//  Created by MAC on 2023-05-24.
//

import SwiftUI

struct CalendarViewEndUser: View {

    @ObservedObject var vm: CalendarViewModel
    
    var body: some View {
        VStack {
            //Title
            HStack {
                // title
                Spacer()
    
                if #available(iOS 16.1, *) {
                    Text("\(vm.calendar.monthSymbols[vm.month - 1]) \(String(vm.year))")
                        .font(.title)
                        .fontDesign(.monospaced)
                } else {
                    // Fallback on earlier versions
                    Text("\(vm.calendar.monthSymbols[vm.month - 1]) \(String(vm.year))")
                        .font(.title)
                }
                Spacer()
                Button {
                    vm.showToday()
                } label: {
                    Text("Today")
                        .bold()
                }

            }
            //
            HStack(spacing: 2) {
                Image(systemName: "chevron.backward.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 35, height: 35)
                    .onTapGesture {
                        vm.prevMonth()
                    }
                // calendar month view
                LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                    if #available(iOS 16.1, *) {
                        Group {
                            Text("SUN")
                            Text("MON")
                            Text("TUE")
                            Text("WED")
                            Text("THU")
                            Text("FRI")
                            Text("SAT")
                        }
                        .bold()
                        .foregroundColor(.secondary)
                        .fontDesign(.monospaced)
                    } else {
                        // Fallback on earlier versions
                        Group {
                            Text("SUN").bold()
                            Text("MON").bold()
                            Text("TUE").bold()
                            Text("WED").bold()
                            Text("THU").bold()
                            Text("FRI").bold()
                            Text("SAT").bold()
                        }
                        .foregroundColor(.secondary)
                    }
                    
                    ForEach(vm.getCalendarDays(), id: \.self) { date in
                        ZStack {
                            // show skyblue circle for dates with sessions
                            if vm.datesWithSessions.contains(where: { $0.0 == date }) {
                                let isStroke = date.isLater(than: Date()) == -1
                                CalCellCircleView(isToday: false, isStroke: isStroke, isOpaque: !vm.isCurrentMonth(date: date))
                            }
                            // show crimson circle for today
                            if date.isLater(than: Date()) == 0 {
                                CalCellCircleView(isToday: true, isStroke: true)
                            }
                            
                            // show date number on the top
                            CalCellNumberView(number: Int(vm.dateFormatter.string(from: date))!, isBlack: vm.isCurrentMonth(date: date))
                            // transparent circle for padding
                            Circle()
                                .frame(width: 35, height: 35, alignment: .center)
                                .foregroundColor(.clear)
                            
                        }
                        .onAppear {
                            print(vm.month, date)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width*0.8)
                Image(systemName: "chevron.forward.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
                    .frame(width: 35, height: 35)
                    .onTapGesture {
                        vm.nextMonth()
                    }
                
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .onAppear {
            vm.showToday()
            print(Date().isLater(than: Date()))
        }
    }
}
struct CalCellNumberView: View {
    let number: Int
    let isBlack: Bool
    var body: some View {
        if #available(iOS 16.1, *) {
            Text("\(number)")
                .fontDesign(.monospaced)
                .foregroundColor(isBlack ? .primary : .secondary)
        } else {
            // Fallback on earlier versions
            Text("\(number)")
                .foregroundColor(isBlack ? .primary : .secondary)
        }
    }
}
//MARK: - CalCellCircle
struct CalCellCircleView: View {
    let isToday: Bool
    let isStroke: Bool
    let isOpaque: Bool
    
    init(isToday: Bool, isStroke: Bool, isOpaque: Bool = false) {
        self.isToday = isToday
        self.isStroke = isStroke
        self.isOpaque = isOpaque
    }

    private var fgColor: Color {
        isToday ? .assetColor.crimson : .assetColor.skyblue.opacity(isOpaque ? 0.5 : 1)
    }
    var body: some View {
        circle
            .frame(width: 35, height: 35, alignment: .center)
            .foregroundColor(fgColor)
    }
    var circle: some View {
        Group {
            if isStroke {
                Circle().stroke(lineWidth: 2)
            } else {
                Circle()
            }
        }
    }
}

struct CalendarViewEndUser_Previews: PreviewProvider {
    static var previews: some View {
        CalendarViewEndUser(vm: CalendarViewModel())
    }
}


