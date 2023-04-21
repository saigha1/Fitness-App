//
//  BookSessionsView.swift
//  Fitness_App
//
//  Created by Xavier on 4/18/23.
//

import SwiftUI

struct BookSessionsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = BookSessionsViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                Group { // Form / Input
                    dayOfTheWeekPicker
                    freeTrial
                    startDatePicker
                    timeSlotPickers
                    lengthPicker
                    location
                    gym
                }
                Divider()
                Group { // Transaction Summary
                    
                }
            }
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
        BookSessionsView()
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
            Spacer()
            Text("Your first session is free of charge.")
        }
    }
    // Start Date
    private var startDatePicker: some View {
        HStack {
            Text("Start Date")
                .bold()
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
            Spacer()
            Text("TODO: Fetch Preferred Location of the Current User")
        }
    }
    private var gym: some View {
        HStack(alignment: .top) {
            Text("Gym")
                .bold()
            Spacer()
            Text("TODO: Fetch Gyms of the Current User and show a picker")
        }
    }
}
