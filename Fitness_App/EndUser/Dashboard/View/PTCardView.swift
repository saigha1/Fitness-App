//
//  PTCardView.swift
//  Fitness_App
//
//  Created by Xavier on 3/29/23.
//

import SwiftUI

struct PTCardView: View {
    let size = UIScreen.main.bounds.width/2.85
    var image: UIImage
    var isFav: Bool = false
    var showCategory: Bool = false
    var body: some View {
        VStack {
            ZStack {
                //MARK: - PT Profile Image
                ImageView(uiImage: image, size: size, cornerRadius: 13, padding: 0)
                    .overlay {
                        LinearGradient(colors: [.clear, .clear, .clear, .assetColor.blue], startPoint: .top, endPoint: .bottom)
                            .if(!showCategory) { _ in
                                EmptyView()
                            }
                    }
                    .cornerRadius(13)
                VStack {
                    //MARK: - Star
                    HStack {
                        Spacer()
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(isFav ? .yellow : .clear)
                            .background {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(isFav ? .secondary : .clear)
                                    .offset(x: 1, y: 1)
                            }
                            .frame(width: 25, height: 25)
                            .padding(7)
                    }
                    Spacer()
                    //MARK: - Training Category
                    Text("Weight-Lifting")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                        .padding(.bottom, 3)
                        .if(!showCategory) { _ in
                            EmptyView()
                        }
                }
            }
            .frame(width: size, height: size)
            //MARK: - PT Name & Rating
            HStack {
                Text("Bob")
                    .bold()
                Spacer()
                Text("4.7/5")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 5)
        }
        .padding(5)
    }
}

//MARK: - Preview
struct PTCardView_Previews: PreviewProvider {
    static let images: [UIImage] = [
        .init(named: "PT1")!,
        .init(named: "PT2")!,
        .init(named: "PT3")!,
        .init(named: "PT4")!,
        .init(named: "PT5")!,
        .init(named: "PT6")!
    ]
    static var previews: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(images, id: \.self) { image in
                    PTCardView(image: image)
                }
            }
        }
    }
}
