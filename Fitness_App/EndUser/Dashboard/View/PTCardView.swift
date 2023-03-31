//
//  PTCardView.swift
//  Fitness_App
//
//  Created by Xavier on 3/29/23.
//

import SwiftUI

struct PTCardView: View {
    let size = UIScreen.main.bounds.width/2.85
    var showCategory: Bool = false
    var pt: PTModel
    var category : typesOfWorkOut
    
    var body: some View {
        VStack {
            ZStack {
                //MARK: - PT Profile Image
                ImageView(uiImage: pt.ptProfileImage.asUIImage(), size: size, cornerRadius: 13, padding: 0)
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
                            .foregroundColor(pt.isFavorite ? .yellow : .clear)
                            .background {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(pt.isFavorite ? .secondary : .clear)
                                    .offset(x: 1, y: 1)
                            }
                            .frame(width: 25, height: 25)
                            .padding(7)
                    }
                    Spacer()
                    //MARK: - Training Category
                    Text("\(category.rawValue)")
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
                Text(pt.name)
                    .bold()
                Spacer()
                Text("\(Double.random(in: 3...5), specifier: "%.1f")/5")
                    .foregroundColor(.secondary)
            }
            .frame(width: size)
            .padding(.horizontal, 5)
        }
        .padding(5)
    }
}

//MARK: - Preview
struct PTCardView_Previews: PreviewProvider {
    static var pt1 = PTModel(id: "", ptProfileImage: (UIImage(named: "PT1")!.jpegData(compressionQuality: 0.09)?.base64EncodedString())!, name: "Michael", email: "Michael@icloud.com", phone: "41641641466", gender: .m, isFeatured: .random(), isFavorite: true, isApproved: true, education: .Diploma, certification: [.CFES], selectedExperience: .One, cityLocation: .Mississauga, gymPreference: [.GoodLife], workoutTypes: [.calisthenic], motto: "Try harder.", description: "", imageString: [""], videoUrl: [""], selectedImage: nil)
    static var pt2 = PTModel(id: "", ptProfileImage: (UIImage(named: "PT6")!.jpegData(compressionQuality: 0.09)?.base64EncodedString())!, name: "Michael", email: "Michael@icloud.com", phone: "41641641466", gender: .m, isFeatured: .random(), isFavorite: false, isApproved: true, education: .Diploma, certification: [.CFES], selectedExperience: .One, cityLocation: .Mississauga, gymPreference: [.GoodLife], workoutTypes: [.calisthenic], motto: "Try harder.", description: "", imageString: [""], videoUrl: [""], selectedImage: nil)
    static var previews: some View {
        VStack {
            PTCardView(pt: pt1, category: .calisthenic)
            PTCardView(showCategory: true, pt: pt2, category: .machine)
        }
    }
}
