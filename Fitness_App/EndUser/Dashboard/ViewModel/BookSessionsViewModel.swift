//
//  BookSessionsViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 4/20/23.
//

import Foundation

class BookSessionsViewModel: ObservableObject {
    // Fields inputs or states
    @Published var selectedDays: [DayOfTheWeek] = []
    @Published var selectedStartDate: Date = Date()
    @Published var selectedStartTime: Date = Date()
    @Published var selectedEndTime: Date = Date() + 7200
    @Published var selectedLength: Int = 1
    @Published var selectedGym : gymPreferrence = .select
}
