//
//  UserProfileView.swift
//  Fitness_App
//
//  Created by Xavier on 2/7/23.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            header
            VStack(alignment: .leading, spacing: 15) {
                personalInfo
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.white)
                    )
                preferences
                healthMetrics
                workoutJouney
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.secondary.opacity(0.2))
                    .padding(.horizontal, 7)
            )
            Spacer()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}


var appointsOfCurrentUser: [WorkOutAppointment] {
    appointments.filter { appointment in
        appointment.userID == userIDMichaelLogan
    }
}
let groupedAppoints = appointsOfCurrentUser.sliced(by: [.year, .month], for: \.date)
let sortedKeys = Array(groupedAppoints.keys).sorted(by: <)
