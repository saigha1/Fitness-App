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
            Text("Upcoming Sessions")
            
            ForEach(Array(vm.datesWithSessions.filter({ (date, _) in
                vm.isCurrentMonth(date: date)
                
            }).enumerated()) , id: \.offset){ offset, element in
                
                let date = element.0
                let transaction = element.1
                VStack{
                    HStack{
                        Text("\(vm.toString(date))")
                        
                        if let pt = vm.getPT(transaction: transaction){
                            Text("\(pt.name)")
                            
                            let gymText = (pt.gymPreference.filter{ gym in
                                guard let endUser = authVM.currentEndUser else { return false }
                                
                                return endUser.preferredGym.contains{ userGym in
                                    userGym.rawValue == gym.rawValue
                                    
                                }
                            }.first?.rawValue)
                            Text(gymText ?? "")
                            
                        }
                        if let start = transaction.startTime, let end = transaction.endTime {
                            Text("\(start.formatted(date: .omitted, time: .shortened)) -  \(end.formatted(date: .omitted, time: .shortened))")
                            
                        }
                    }
                    .padding(.vertical, 0)
                    .background(Color.gray.opacity(offset % 2 == 0 ? 0.7 : 0.2).cornerRadius(3))
                    .padding(.vertical, 0)
//                    Divider()
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
