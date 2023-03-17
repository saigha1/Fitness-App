//
//  UserProfileViewChart.swift
//  Fitness_App
//
//  Created by Xavier on 2/9/23.
//  This file is temp. Chart components for "Workout Jouney Section" in (End) User Profile View

import SwiftUI
import Charts


//TODO: - Implement Chart Data Source & Delegate
var appointsOfCurrentUser: [WorkOutAppointment] {
    appointments.filter { appointment in
        appointment.userID == userIDMichaelLogan
    }
}
let groupedAppoints = appointsOfCurrentUser.sliced(by: [.year, .month], for: \.date)
let sortedKeys = Array(groupedAppoints.keys).sorted(by: <)


//MARK: - Workout Journey Section

extension UserProfileView {
    var workoutJouneySection: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                //Title
                HStack {
                    userProfileIcon_Journey
                    Text("Workout Journey")
                        .bold()
                }
                .foregroundColor(.indigo)
                
                Divider()
                
                //Chart
                if #available(iOS 16.0, *) {
                    Chart {
                        ForEach(sortedKeys, id: \.self) { key in
                            BarMark(x: .value("Month", key.asStringYYYYMM()), y: .value("# of workout", groupedAppoints[key]?.count ?? 0))
                                .foregroundStyle(.indigo.opacity(0.7))
                            LineMark(x: .value("Month", key.asStringYYYYMM()), y: .value("# of workout", groupedAppoints[key]?.count ?? 0))
                                .foregroundStyle(.indigo)
                            
                        }
                    }
                } else {
                    //Fallback on earlier versions
                    HStack(alignment: .bottom) {
                        ForEach(sortedKeys, id: \.self) { key in
                            VStack {
                                Spacer()
                                Text("\(groupedAppoints[key]?.count ?? 0)")
                                    .offset(x: 0, y: 10)
                                Rectangle()
                                    .fill(Color.indigo)
                                    .frame(
                                        width: CGFloat(UIScreen.main.bounds.width/CGFloat(sortedKeys.count)/3 * 2),
                                        height: CGFloat(groupedAppoints[key]?.count ?? 0) * 15)
                                Text(key.asString("MMM-yy"))
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    .frame(height: 20)
                            }
                        }
                    }
                }
                
                //Chart Description
                Text("Workout appointments attended by month")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.secondary)
            }
        }
    }
}
