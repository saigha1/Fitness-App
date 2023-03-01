//
//  EndUserCalendarView.swift
//  Fitness_App
//
//  Created by Xavier on 2/27/23.
//

import SwiftUI

struct EndUserCalendarView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
                    .navigationTitle("Calendar")
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                content
                    .navigationTitle("Calendar")
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
