//
//  PTPageProfileView.swift
//  Fitness_App
//
//  Created by Xavier on 3/31/23.
//

import SwiftUI

struct PTPageProfileView: View {
    var pt: PTModel
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(pt.name + "’s Profile")
                        .bold()
                        .font(.title)
                    //badge
                    Text("Trainer")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .bold()
                        .padding(2)
                        .background(Color.assetColor.blue.cornerRadius(5))
                        .padding(.horizontal, 10)
                }
                //MARK: - Image & Video Preview
                HStack {
                    Image(uiImage: pt.ptProfileImage.asUIImage())
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(15)
                }
                //MARK: - Title with favicon, name, rating & chat button
                HStack {
                    //Fav icon
                    pt.isFavorite ?
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    :
                    Image(systemName: "star")
                        .foregroundColor(.secondary)

                    Spacer()
                    //Rating
                    Text("\(Double.random(in: 3...5), specifier: "%.1f") / 5")
                        .bold()
                    Spacer()
                    Button {
                        print("Go to chat view")
                    } label: {
                        sharedIcon_Chat
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .scaledToFit()
                            .foregroundColor(.assetColor.blue)
                            .padding(.trailing, 10)
                    }
                    
                }
                .padding(.horizontal, 10)
                //MARK: - Details
                VStack {
                    makeRow(title: "Training Category(ies)") {
                        ForEach(pt.workoutTypes, id: \.rawValue) {
                            if $0 != .select {
                                Text($0.rawValue)
                            }
                        }
                    }
                    makeRow(title: "Experience Level") {
                        Text(pt.selectedExperience.rawValue)
                    }
                    makeRow(title: "Education") {
                        Text(pt.education.rawValue)
                    }
                    makeRow(title: "Certification") {
                        ForEach(pt.certification, id: \.rawValue) {
                            if $0 != .select {
                                Text($0.rawValue)
                            }
                        }
                    }
                    makeRow(title: "Motto") {
                        Text(pt.motto)
                    }
                    makeRow(title: "Location") {
                        Text(pt.cityLocation.rawValue)
                    }
                    makeRow(title: "Gym") {
                        ForEach(pt.gymPreference, id: \.rawValue) {
                            if $0 != .select {
                                Text($0.rawValue)
                            }
                        }
                    }
                    makeRow(title: "Description") {
                        Text(pt.description)
//                        Text("Weight-Lifting professional with over 10 years experience training individuals and athletes. Studied at UFT in Life Sciences and Fitness Certification from GoodLife. Hold a Fitness Certificate IV. Currently Offering monthly sessions, workout plans and diet plans. Get in touch with me to learn more!")
                    }
                }
                .padding(.horizontal, 45)
                //MARK: - Purchase buttons
                HStack {
                    Button {
                        print("Book sessions tapped.")
                    } label: {
                        Text("Book Sessions")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 140, height: 40, alignment: .center)
                            .background(Color.assetColor.purple.cornerRadius(10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Color.assetColor.purple)
                            }
                    }
                    Button {
                        print("Purchase Plans tapped.")
                    } label: {
                        Text("Purchase Plans")
                            .bold()
                            .foregroundColor(.assetColor.purple)
                            .frame(width: 140, height: 40, alignment: .center)
                            .background(Color.assetColor.cyan.cornerRadius(10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Color.assetColor.purple)
                            }
                    }
                }
            }
            .padding(.bottom, 50)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PTPageView_Previews: PreviewProvider {
    static var previews: some View {
        PTPageProfileView(pt: emptyPTModel)
    }
}

//MARK: - View Utilities
extension PTPageProfileView {
    private func divider(widthPct: Double) -> some View {
        Divider()
            .frame(width: UIScreen.main.bounds.width * widthPct)
            .overlay(.secondary)
    }
    private func makeRow(title: String, @ViewBuilder value: () -> some View) -> some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(title).bold()
                        .font(.system(size: 12))
                        .frame(width: UIScreen.main.bounds.width / 4, alignment: .leading)
                }
                Spacer()
                VStack(alignment: .leading) {
                    value()
                        .font(.system(size: 10))
                        .frame(width: 170, alignment: .leading)
                }
            }
            divider(widthPct: 0.8)
        }
    }
}
