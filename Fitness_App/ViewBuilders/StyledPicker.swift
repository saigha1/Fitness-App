//
//  StyledPicker.swift
//  Fitness_App
//
//  Created by Xavier on 3/13/23.
//

import SwiftUI

struct StyledPicker<Content: View>: View {
    
    let picker: Content
    
    init(title: String, @ViewBuilder picker: () -> Content) {
        self.title = title
        self.picker = picker()
        
    }
    var title: String
    var body: some View {
        if #available(iOS 16.0, *) {
            return picker
                .pickerStyle(.navigationLink)
        } else {
            return HStack {
                Text(title)
                Spacer()
                picker
                    .pickerStyle(.menu)
            }
        }
    }
}


struct StyledPicker_Previews: PreviewProvider {
    static var options: [String] = ["Option 1", "Option 2", "Option 3"]
    static var picker: some View {
        Picker("Select an option", selection: .constant(options[0])) {
            ForEach(options, id: \.self) {
                Text($0)
            }
        }
    }
    static var previews: some View {
        NavigationView {
            ScrollView {
                StyledPicker(title: "Preview Options") { picker }
                StyledPicker(title: "Preview Options") { picker }
                StyledPicker(title: "Preview Options") { picker }
            }
            .padding()
            .navigationTitle("Styled Picker")
        }
    }
}
