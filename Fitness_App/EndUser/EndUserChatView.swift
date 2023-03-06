//
//  EndUserChatView.swift
//  Fitness_App
//
//  Created by Xavier on 2/27/23.
//

import SwiftUI

struct EndUserChatView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
                    .navigationTitle("Chat")
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                content
                    .navigationTitle("Chat")
            }
        }
    }
}

struct EndUserChatView_Previews: PreviewProvider {
    static var previews: some View {
        EndUserChatView()
    }
}

extension EndUserChatView {
    private var content: some View {
        Text("Chat contents goes here")
    }
}
