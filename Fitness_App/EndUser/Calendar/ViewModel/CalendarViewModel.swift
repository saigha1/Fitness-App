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
    var pTModel = [PTModel]()
    
//    @Published var startDate: Date = Date()
//    @Published var endDate: Date = Date()
    
    init(user: NewEndUser? = nil) {
        self.month = 1
        self.year = 1999
        if user != nil {
            self.user = user!
        }
        loadTransactions()
        let start = Date()
        guard let allPTApproved: [PTModel] = load(filename: "PTs.json", location: .document) else { return }
        performanceCheck(start: start, end: Date())
        print("JSON: ")
        pTModel = allPTApproved
        
    }
    
    func performanceCheck(start: Date, end : Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd hh mm ss SSS"
        print("tiME: ", formatter.string(from: start), formatter.string(from: end))
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
                dateComponent: DateComponents(hour: transaction.startTime?.hour, minute: transaction.startTime?.minute, second: 0)
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
    func isMonthInView(date: Date) -> Bool {
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
        guard let PTFound: PTModel = pTModel.first(where: { $0.id == transaction.trainerUID }) else { return nil }
        return PTFound
    }

    func getPT(transaction : Transaction) -> PTModel? {
        guard let PTFound: PTModel = pTModel.first(where: { $0.id == transaction.trainerUID }) else { return nil }
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

//MARK: - Upcoming Sessions & Sorting Logic for the List
extension CalendarViewModel {
    
    var upcomingSessionSortedByDateAscending : [(offset: Int, element: Session)]{
    upcomingSessionsEnumerated
            .sorted { lhs, rhs in
                let session1 = lhs.element
                let session2 = rhs.element
                    return  session1.0 < session2.0
            }
    }
    
//MARK: -Improved performance by 1600% or 160x by storing filtered & stored result separately and loading JSON data in init call
    var upcomingSessionSortedByDateDescending : [(offset: Int, element: Session)]{
        upcomingSessionSortedByDateAscending.reversed()
    }
    
    var upcomingSessionsEnumerated: [(offset: Int, element: Session)] {
        var sessions: Sessions {
            datesWithSessions
                .filter({ (date, _) in
                    isMonthInView(date: date) && date > Date()
                })

        }
        return Array(sessions.enumerated())
    }
    
    
    var upcomingSessionsStorage: [(offset: Int, element: Session)] {
        var sessions: Sessions {
            datesWithSessions
                .filter({ (date, _) in
                    date > Date()
                    
                })
        }
        return Array(sessions.enumerated())
    }
    
    func nextSession() -> Session?{
        let sessions: Sessions =
            upcomingSessionsStorage
                .sorted { lhs, rhs in
                let session1 = lhs.element
                let session2 = rhs.element
                
                return session1.0 < session2.0
                
            }
            .map { _ , session in
                    session
            }
        
        
        guard let first = sessions.first else { return nil }
        return first
    }
    
    func isNextSession(_ session : Session) -> Bool{
        guard let next = nextSession() else { return false}
        return session.0 == next.0 &&  session.1 == next.1
        
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



