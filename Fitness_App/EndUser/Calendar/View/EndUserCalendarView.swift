//
//  EndUserCalendarView.swift
//  Fitness_App
//
//  Created by Xavier on 2/27/23.
//

import SwiftUI

struct EndUserCalendarView: View {
    
    var body: some View {
        NavigationView {
            VStack{
                CalendarViewEndUser()
                legend
                trainerContactCard
                upcomingSessions
                    
            }
            .navigationTitle("Calendar")
            
            
        }
    }
    var legend: some View {
        VStack{
            Text("")
        }
        
    }
    
    var trainerContactCard: some View{
        VStack{
            GroupBox{
                HStack{
                    Image(systemName: "person.circle")
                    VStack{
                        Text("")
                        
                    }
                    Spacer()
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
