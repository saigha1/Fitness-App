//
//  PhotoView.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-22.
//

import SwiftUI

struct PhotoView: View {
//    var uiImageOne: UIImage
//    var uiImageTwo: UIImage
//    var uiImageThree: UIImage
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.gray)
                .aspectRatio(1.0, contentMode: .fit)
                .overlay{
                    HStack{
                        Rectangle()
                            .fill(Color.gray)
                            .overlay {
                                Image("PT1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                        Rectangle()
                            .fill(Color.gray)
                            .overlay {
//                                Image(uiImage: UIImage("PT1"))
                                Image("PT1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                        Rectangle()
                            .fill(Color.gray)
                            .overlay {
//                                Image(uiImage: UIImage("PT1"))
                                Image("PT1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                                
                    }
                }
            
        }
    }
}

//struct PhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoView(uiImageOne: "photo", uiImageTwo: "photo", uiImageThree: "photo")
//    }
//}
