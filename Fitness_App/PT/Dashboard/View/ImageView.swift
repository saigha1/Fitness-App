//
//  ImageView.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-23.
//

import SwiftUI

struct ImageView: View {
    var uiImage: UIImage
    
    var body: some View {
     
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(2)
                .padding(1)
                .clipped()
    }
}
