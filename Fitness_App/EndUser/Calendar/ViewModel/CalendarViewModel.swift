//
//  CalendarViewModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-05-24.
//

import Foundation

typealias Session = (Date, Transaction)
typealias Sessions = [Session]
class CalendarViewModel: ObservableObject {
    
    @Published var month: Int = 1
    @Published var year: Int = 1999
    
    // Sort Descriptor for upcoming sessions
    @Published var selectedSortOption: SessionSortOption = .date
    @Published var isAscending: Bool = true
    private var user: NewEndUser? = nil
    var transactions: [Transaction] = []
    
    init(user: NewEndUser? = nil) {
        self.month = 1
        self.year = 1999
        if user != nil {
            self.user = user!
        }
        loadTransactions()
    }
    func loadTransactions() {
        self.transactions = load(filename: "Transactions.json", location: .document) ?? []
    }
    var datesWithSessions : Sessions {
        var results : Sessions = []
        for transaction in transactions {
            guard let length = transaction.length else { return results }
            guard let startDate = transaction.startDate else { return results }
            guard let weekDays = transaction.weekDays else { return results }
            let endDate = startDate.addMonth(length)
            
            let dates = Calendar.current.getAllDates(
                dateInterval: DateInterval(start: startDate, end: endDate),
                dateComponent: DateComponents(hour: 0, minute: 0, second: 0)
            )
            
            for date in dates{
                guard let weekday = date.asDayOfWeek() else { return results }
                
                if weekDays.contains(weekday){
                    results.append((date, transaction))
                }
            }
        }
        
        return results.sorted {
            $0.0 < $1.0
        }
        }
    
    
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var formatter: DateFormatter {
        dateFormatter(format: "MMM dd, yyyy")
    }
    var timeFormatter: DateFormatter {
        dateFormatter(format: "HH:ss")
    }
    func dateFormatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
    func toString(_ date: Date, formatter: DateFormatter? = nil) -> String {
        if formatter == nil {
            return self.formatter.string(from: date)
        } else {
            return formatter!.string(from: date)
        }
    }
    
    // load current year and month
    func showToday() {
        year = calendar.component(.year, from: Date())
        month = calendar.component(.month, from: Date())
    }
    func getCalendarDays() -> [Date] {
        let startDate = calendar.date(from: DateComponents(year: year, month: month))!
        return calendar.getAllRealDays(for: startDate)
    }
    func isCurrentMonth(date: Date) -> Bool {
        let components = calendar.dateComponents([.year, .month], from: date)
        return components.month == month && components.year == year
    }
    
    func prevMonth(){
        if month == 1 {
            month = 12
            year -= 1
        } else {
            month -= 1
        }
    }
    
    func nextMonth(){
        if month == 12 {
            month = 1
            year += 1
        } else {
            month += 1
        }
    }
    
}

//MARK: - PT Contact Banner Functions
extension CalendarViewModel {
    var pt: PTModel? {
        let allDates = datesWithSessions.filter { $0.0.isLater(than: Date()) == 1 }.sorted { $0.0 < $1.0 }
        guard let transaction = allDates.first?.1 else { return nil }
        guard let allPTApproved: [PTModel] = load(filename: "PTs.json", location: .document) else { return nil }
        guard let PTFound: PTModel = allPTApproved.first(where: { $0.id == transaction.trainerUID }) else { return nil }
        return PTFound
    }

    func getPT(transaction : Transaction) -> PTModel? {
            guard let allPTApproved: [PTModel] = load(filename: "PTs.json", location: .document) else { return nil }
            guard let PTFound: PTModel = allPTApproved.first(where: { $0.id == transaction.trainerUID }) else { return nil }
            return PTFound
    }
    func getGymText(transaction: Transaction, user: NewEndUser?) -> String {
        guard let pt = getPT(transaction: transaction) else { return "" }
        let gymText = (pt.gymPreference.filter{ gym in
            guard let endUser = user else { return false }
            return endUser.preferredGym.contains{ userGym in
                userGym.rawValue == gym.rawValue
            }
        }.first?.rawValue ?? "")
        return gymText
    }
}

//MARK: - Upcoming Sessions & Sorting Logic
extension CalendarViewModel {
    var upcomingSessionsEnumerated: [(offset: Int, element: Session)] {
        var sessions: Sessions {
            datesWithSessions
                .filter({ (date, _) in
                    isCurrentMonth(date: date)
                })
                .sorted { session1, session2 in
                    switch selectedSortOption {
                    case .trainer:
                        guard let trainer1 = getPT(transaction: session1.1) else { return false }
                        guard let trainer2 = getPT(transaction: session2.1) else { return false }
                        return isAscending ? trainer1.name < trainer2.name : trainer1.name > trainer2.name
                    case .gym:
                        let gymText1 = getGymText(transaction: session1.1, user: self.user)
                        let gymText2 = getGymText(transaction: session2.1, user: self.user)
                        return isAscending ? gymText1 < gymText2 : gymText1 > gymText2
                    case .time:
                        guard let startTime1 = session1.1.startTime else { return false }
                        guard let startTime2 = session2.1.startTime else { return false }
                        let startHour1 = Calendar.current.component(.hour, from: startTime1)
                        let startMinute1 = Calendar.current.component(.minute, from: startTime1)
                        let startHour2 = Calendar.current.component(.hour, from: startTime2)
                        let startMinute2 = Calendar.current.component(.minute, from: startTime2)
                        let startTime1IsGreater = startHour1 > startHour2 ? true : startMinute1 > startMinute2
                        return isAscending && startTime1IsGreater
                    default: // date
                        return isAscending ? session1.0 < session2.0 : session1.0 > session2.0
                    }
                }
        }
        return Array(sessions.enumerated())
    }
    func reorderSessions(_ option: SessionSortOption) {
        if option == selectedSortOption {
            isAscending.toggle()
        } else {
            selectedSortOption = option
        }
    }
}
enum SessionSortOption: String, CaseIterable {
    case date = "Date"
    case trainer = "Trainer"
    case gym = "Gym & Location"
    case time = "Time"
}
