//
//  EndUserExploreView.swift
//  Fitness_App
//
//  Created by Xavier on 2/27/23.
//

import SwiftUI

struct EndUserExploreView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
                    .navigationTitle("Explore")
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                content
                    .navigationTitle("Explore")
            }
        }
    }
}

struct EndUserExploreView_Previews: PreviewProvider {
    static var previews: some View {
        EndUserExploreView()
    }
}

extension EndUserExploreView {
    private var content: some View {
        Text("Exlpore contents goes here.")
    }
}
