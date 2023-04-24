//
//  BookSessionsView.swift
//  Fitness_App
//
//  Created by Xavier on 4/16/23.
//

import SwiftUI

struct BookSessionsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = BookSessionsViewModel()
    @EnvironmentObject var authVM : AuthViewModel
    var pT : PTModel
    
    var body: some View {
        NavigationView {
            List {
                Group { // Form / Input
                    dayOfTheWeekPicker
                    freeTrial
                    startDatePicker
                    timeSlotPickers
                    lengthPicker
                    location
                    gym
                }
                Group { // Transaction Summary
                    
                }
            }
            .listStyle(.inset)
            .padding()
            .navigationTitle("Book Sessions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }, label: {
                        Label("Dismiss", systemImage: "xmark")
                            .foregroundColor(Color.assetColor.red)
                    })
                }
            }
        }
        
    }
}

struct BookSessionsView_Previews: PreviewProvider {
    
    static var previews: some View {
        BookSessionsView(pT: .init(id: "Hello", ptProfileImage: "Hello", name: "Hello", email: "Hello", phone: "Hello", gender: .m, isFeatured: true, isFavorite: true, isApproved: true, education: .Bachelors, certification: [.CanFitProI], selectedExperience: .One, cityLocation: .Mississauga, gymPreference: [.FitnessPlanet, .GoodLife, .LAFitness], workoutTypes: [.calisthenic, .machine, .americanBoxing], motto: "Hello", description: "Hello", imageString: ["Hello"], videoUrl: ["Hello"])).environmentObject(AuthViewModel())
    }
}

//MARK: - View Components (Form)
extension BookSessionsView {
    // Day of the week picker row
    private var dayOfTheWeekPicker: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Date")
                    .bold()
                    .font(.custom("System", fixedSize: 16))
                    .fontWeight(.heavy)
                Text("Select 2 - 5 days/week")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            DayOfTheWeekPicker(selectedDays: vm.selectedDays)
        }
    }
    // Free trial text
    private var freeTrial: some View {
        HStack {
            Text("Free Trial")
                .bold()
                .font(.custom("System", fixedSize: 16))
            Spacer()
            Text("Your first session is free of charge.")
        }
    }
    // Start Date
    private var startDatePicker: some View {
        HStack {
            Text("Start Date")
                .bold()
                .font(.custom("System", fixedSize: 16))
            Spacer()
            DatePicker("Start Date", selection: $vm.selectedStartDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
        }
    }
    // Time Slot
    private var timeSlotPickers: some View {
        HStack {
            Text("Time Slot")
                .bold()
                .font(.custom("System", fixedSize: 16))
            Spacer()
            DatePicker("Start Time", selection: $vm.selectedStartDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
            Text("~")
            DatePicker("End Time", selection: $vm.selectedEndTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }
    private var lengthPicker: some View {
        HStack {
            Text("Length")
                .bold()
                .font(.custom("System", fixedSize: 16))
            Spacer()
            Picker("Length", selection: $vm.selectedLength, content: {
                let lengthOptions = [1, 3, 6, 9, 12, 24]
                ForEach(lengthOptions, id: \.self) { len in
                    Text("\(len) month" + (len == 1 ? "" : "s"))
                }
            })
                .labelsHidden()
        }
    }
    private var location: some View {
        HStack(alignment: .top) {
            Text("Location")
                .bold()
                .font(.custom("System", fixedSize: 16))
            Spacer()
            Text(authVM.currentEndUser?.gymLocation ?? "Cannot find gym location")
            
        }
    }
    private var gym: some View {
        HStack(alignment: .top) {
            Text("Gym")
                .bold()
                .font(.custom("System", fixedSize: 16))
            Spacer()
            Picker("Gym: ", selection: $vm.selectedGym, content: {
                
                //Comparison
                let gymsInCommon = pT.gymPreference.filter({PTGym in
                    guard let userGyms = authVM.currentEndUser?.preferredGym else { return true }
                    var hasCommon = false
                    
                    for userGym in userGyms {
                            if (userGym.rawValue == PTGym.rawValue) && PTGym != .select {
                                hasCommon = true
                            }
                    }
                    return hasCommon
                })
            
                ForEach([gymPreferrence.select] + gymsInCommon, id: \.self) { gym in
                    Text(gym.rawValue)
                }
            }) .labelsHidden()
//            Text(authVM.currentEndUser?.preferredGym ?? "Cannot find preferred gym")
        }
    }
}
