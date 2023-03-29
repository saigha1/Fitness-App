//
//  ImageView.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-23.
//

import SwiftUI

struct ImageView: View {
    var uiImage: UIImage
    var size: CGFloat = 80
    var cornerRadius: CGFloat = 2
    var padding: CGFloat = 1
    var body: some View {
     
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
//                .aspectRatio(contentMode: .fit)
                .cornerRadius(cornerRadius)
                .padding(padding)
                //.clipped()
    }
}

struct ImageView_Preview: PreviewProvider {
    static let image = UIImage(named: "PT1")!
    static var previews: some View {
        VStack {
            ImageView(uiImage: image)
            ImageView(uiImage: image, size: 100, cornerRadius: 13, padding: 1)
        }
    }
}
