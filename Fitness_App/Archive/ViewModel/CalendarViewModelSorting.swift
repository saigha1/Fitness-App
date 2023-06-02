//
//  CalendarViewModelSorting.swift
//  Fitness_App
//
//  Created by MAC on 2023-06-02.
//

import Foundation


extension CalendarViewModel {
    //    var upcomingSessionSorted : [(offset: Int, element: Session)]{
    //        let start = Date()
    //        let result = upcomingSessionsEnumerated
    //            .sorted { lhs, rhs in
    //                let session1 = lhs.element
    //                let session2 = rhs.element
    //
    //                switch selectedSortOption {
    //                case .trainer:
    //                    guard let trainer1 = getPT(transaction: session1.1) else { return false }
    //                    guard let trainer2 = getPT(transaction: session2.1) else { return false }
    //                    let result = isAscending ? trainer1.name < trainer2.name : trainer1.name > trainer2.name
    //                    print("End-Time: ", Date())
    //                    return result
    //                case .gym:
    //                    let gymText1 = getGymText(transaction: session1.1, user: self.user)
    //                    let gymText2 = getGymText(transaction: session2.1, user: self.user)
    //                    return isAscending ? gymText1 < gymText2 : gymText1 > gymText2
    //                case .time:
    //                    guard let startTime1 = session1.1.startTime else { return false }
    //                    guard let startTime2 = session2.1.startTime else { return false }
    //                    let startHour1 = Calendar.current.component(.hour, from: startTime1)
    //                    let startMinute1 = Calendar.current.component(.minute, from: startTime1)
    //                    let startHour2 = Calendar.current.component(.hour, from: startTime2)
    //                    let startMinute2 = Calendar.current.component(.minute, from: startTime2)
    //                    let startTime1IsGreater = startHour1 > startHour2 ? true : startMinute1 > startMinute2
    //                    return isAscending ? startTime1IsGreater : !startTime1IsGreater
    //                default: // date
    //                    return isAscending ? session1.0 < session2.0 : session1.0 > session2.0
    //                }
    //            }
    ////        print("Sorting")
    ////        performanceCheck(start: start, end: Date())
    //        return result
    //    }
}
