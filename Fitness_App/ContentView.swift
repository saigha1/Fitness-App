//
//  ContentView.swift
//  Fitness_App
//
//  Created by MAC on 2022-12-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, Content View!")
            .bold()
            .foregroundColor(.white)
            .padding()
            .background(Color.assetColor.blue.cornerRadius(5)) // using static asset color in Color extension
            .frame(width: 240, height: 50, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
