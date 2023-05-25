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
            VStack{
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
                            VStack{
                                HStack {
                                    Text(pt.name)
                                        .bold()
                                        .font(.title2)
                                    Text("Trainer")
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.assetColor.blue.cornerRadius(10))
                                }

//                                if let workoutType = pt.workoutTypes.filter({ ptType in
//                                    print("Step 1")
//                                    guard let user = authVM.currentEndUser else {
//                                        print("Step 2")
//                                        return false
//                                    }
//                                    return user.typesOfWorkOut.contains { userType in
//                                        print("Step 3")
//                                        return userType.rawValue == ptType.rawValue
//                                    }
//                                }).first {
//                                    Text(workoutType.rawValue)
//                                        .onAppear {
//                                            print("Step 4")
//                                        }
//                                }
                            }
                            Spacer()
                            sharedIcon_Chat
                                .resizable()
                                .foregroundColor(.secondary)
                                .frame(width: 29, height: 29)
                        }
                    }
                    .padding(15)
                }
            }
        }
    }
    
    var upcomingSessions : some View{
        VStack{
            Text("Upcoming Sessions")
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
