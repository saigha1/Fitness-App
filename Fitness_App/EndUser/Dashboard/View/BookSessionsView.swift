//
//  BookSessionsView.swift
//  Fitness_App
//
//  Created by Xavier on 4/18/23.
//

import SwiftUI

struct BookSessionsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                DatePickerCell()
            }
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

struct DatePickerCell: View {
    var body: some View {
        Path() { p in
            p.move(to: CGPoint(x: 50, y: 50))
            p.addLine(to: CGPoint(x: 150, y: 150))
            p.addLine(to: CGPoint(x: 190, y: 150))
        }
        .foregroundColor(.black)
    }
}
