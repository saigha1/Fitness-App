//
//  EndUserCalendarView.swift
//  Fitness_App
//
//  Created by Xavier on 2/27/23.
//

import SwiftUI

struct EndUserCalendarView: View {
    @StateObject var vm = CalendarViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        NavigationView {
            ScrollView{
                CalendarViewEndUser(vm: vm)
                CalendarLegendViewEndUser()
                trainerContactCard
                upcomingSessions
                
            }
            .navigationTitle("Calendar")
        }
    }
    
    var trainerContactCard: some View{
        Group {
            if let pt = vm.pt {
                VStack{
                    GroupBox{
                        HStack{
                            Image(uiImage: pt.ptProfileImage.asUIImage())
                                .resizable()
                                .frame(width: 52, height: 52)
                                .cornerRadius(15)
                            VStack(alignment: .leading){
                                HStack {
                                    Text(pt.name)
                                        .bold()
                                        .font(.title2)
                                    Text("Trainer")
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(3)
                                        .background(Color.assetColor.blue.cornerRadius(10))
                                }
                                .padding(0)
                                Spacer()
                                    .frame(height:0)
                                if let workoutType = pt.workoutTypes.filter({ ptType in
                                    guard let user = authVM.currentEndUser else {
                                        return false
                                    }
                                    return user.typesOfWorkOut.contains { userType in
                                        return userType.rawValue == ptType.rawValue
                                    }
                                }).first {
                                    Text(workoutType.rawValue)
                                }
                            }
                            Spacer()
                            sharedIcon_Chat
                                .resizable()
                                .foregroundColor(.secondary)
                                .frame(width: 29, height: 29)
                        }
                    }
                    .padding(.horizontal, 60)
                }
            }
        }
        
    }
    
    var upcomingSessions : some View{
        
        VStack{
            HStack {
                Text("Upcoming Sessions")
                    .bold()
                    .font(.title2)
                    .padding(.leading)
                    .padding(.bottom, 5)
                Spacer()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
            }
            // Header Row
            HStack {
                Spacer()
                ForEach(SessionSortOption.allCases, id: \.rawValue) { option in
                    HStack {
                        Text(option.rawValue).bold()
                        if vm.selectedSortOption == option {
                            Image(systemName: vm.isAscending ? "chevron.up" : "chevron.down")
                                .resizable()
                                .frame(width: 12, height: 8)
                                .scaleEffect(0.6)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            vm.reorderSessions(option)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 5)
            .font(.caption)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.gray.cornerRadius(3))
            .padding(.horizontal, 10)
            
            ForEach(vm.upcomingSessionsEnumerated, id: \.offset){ offset, element in
                
                let date = element.0
                let transaction = element.1
                VStack{
                    HStack{
                        Spacer()
                        Text("\(vm.toString(date))")
                        Spacer()
                        if let pt = vm.getPT(transaction: transaction){
                            Text("\(pt.name)")
                                .if( vm.isNextSession(element) , transform: { view in
                                    view.bold()
                                    
                                })
                            Spacer()
                            Text(vm.getGymText(transaction: transaction, user: authVM.currentEndUser) + ", " + transaction.location!.rawValue)
                            
                        }
                        Spacer()
                        if let start = transaction.startTime, let end = transaction.endTime {
                            Text(vm.toString(start, formatter: vm.timeFormatter) + "-" + vm.toString(end, formatter: vm.timeFormatter))
                            
                        }
                        Spacer()
                    }
                    .font(.footnote)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .padding(.vertical, 0)
                    .background(Color.gray.opacity(offset % 2 != 0 ? 0.7 : 0.2).cornerRadius(3))
                    .padding(.vertical, 0)
                }
            }
        }
        
    }
}


struct EndUserCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        EndUserCalendarView()
    }
}

extension EndUserCalendarView {
    private var content: some View {
        Text("Calendar contents goes here.")
    }
}
