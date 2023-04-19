//
//  PTPageProfileView.swift
//  Fitness_App
//
//  Created by Xavier on 3/31/23.
//

import SwiftUI
import AVKit

struct PTPageProfileView: View {
    var pt: PTModel
    @State var mediaFiles: [String] = [""]
    @State var counter: Int = 0
    @State var showLarge : Bool = false
    @State var showBookSessions: Bool = false
    
    var body: some View {
        ZStack{
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
                        // Previous Button (Left)
                        Button {
                            previousImage()
                        } label: {
                            Image(systemName: "chevron.forward.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .rotationEffect(Angle(degrees: 180))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        // Images/Video thumbnails
                        ZStack {
                            ForEach(0...mediaFiles.count-1, id: \.self) { index in
                                let string = mediaFiles.reversed()[index]
                                Group {
                                    if string.hasSuffix(".mp4") {
                                        VideoPlayer(player: .init(url: URL(string: string)!))
                                    } else {
                                        string.toView { $0 }
                                    }
                                }
                                .frame(width: 200, height: 200, alignment: .center)
                                .scaledToFill()
                                .cornerRadius(15)
                                
                                .blur(radius: index == (mediaFiles.count-1) ? 0 : 2)
                                .background(
                                    Color.white
                                        .frame(width: 200, height: 200, alignment: .center)
                                        .cornerRadius(15)
                                )
                                .offset(x: CGFloat(index) * -4, y: CGFloat(index) * 2)
                                .onTapGesture(perform: {
                                    counter = index
                                    withAnimation{
                                        showLarge.toggle()
                                    }
                                })
                            }
                            
                            .shadow(color: .secondary, radius: 2)
                            .offset(x: 8, y: -4)
                        }
                        .frame(width: 220, height: 200, alignment: .center)
                        Spacer()
                        
                        // Next Button (Right)
                        Button {
                            nextImage()
                        } label: {
                            Image(systemName: "chevron.forward.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 15)
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
                            showBookSessions.toggle()
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
                        .sheet(isPresented: $showBookSessions) {
                            BookSessionsView()
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
            Color.primary.opacity(showLarge ? 0.7 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        showLarge.toggle()
                    }
                }
            if showLarge{
                imageTapped(mediaFiles[0])
                    .onTapGesture(count: 2) {
                        withAnimation{
                            showLarge.toggle()
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded({ gesture in
                                let endLocation = gesture.location
                                let startLocation = gesture.startLocation
                                let changeInX = endLocation.x - startLocation.x
                                let changeInY = endLocation.y - startLocation.y
                                withAnimation {
                                    if abs(changeInY) > 200 { // dismiss if change in y is greater than 200
                                        showLarge.toggle()
                                    } else if abs(changeInX) > 100 { // update current index if change in x is greater than 100
                                        if changeInX > 0 {
                                            previousImage()
                                        } else {
                                            nextImage()
                                        }
                                    }
                                }
                            })
                    )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            mediaFiles = ([pt.ptProfileImage] + pt.imageString + pt.videoUrl)
        }
        .fullScreenCoverWithDismissButton(isPresented: .init(get: {
            showLarge && mediaFiles[0].hasSuffix(".mp4")
        }, set: { _ in
            showLarge = false
        })) {
            imageTapped(mediaFiles[0])
        }
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
    
    func imageTapped(_ string : String) -> some View{
        var width: CGFloat = 0
        var height: CGFloat = 0
            
        let image = string.asUIImage()
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        if imageWidth > imageHeight {
            // Landscape image
            // Use screen width if < than image width
            width = imageWidth > UIScreen.main.bounds.width ? UIScreen.main.bounds.width : imageWidth
            // Scale height
            height = width/imageWidth * imageHeight
        } else {
            // Portrait
            // Use 600 if image height > 600
            height = imageHeight > (UIScreen.main.bounds.height*0.6) ? (UIScreen.main.bounds.height*0.6) : height
            // Scale width
            width = height/imageHeight * imageHeight
        }
        return Group {
            if string.hasSuffix(".mp4") {
                let player : AVPlayer = .init(url: URL(string: string)!)
                
                VideoPlayer(player: player){
                    Color.primary.opacity(0.00001)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .onTapGesture(count: 2){
                            withAnimation{
                                showLarge.toggle()
                            }
                        }
                }
                .onAppear{
                    player.play()
                }
                .onDisappear {
                    player.pause()
                }
                
            } else {
                Image(uiImage: image).resizable().frame(width: width, height: height)
            }
        }
    }
    
    //MARK: - Swipe / Button logic to change current index of images
    func previousImage() {
        if counter > 0 {
            counter -= 1
        } else if counter == 0 {
            counter = mediaFiles.count - 1
        }
        if mediaFiles.count > 0 {
            mediaFiles.insert(mediaFiles.removeLast(), at: 0)
        }
    }
    func nextImage() {
        if counter < mediaFiles.count-1 {
            counter += 1
        } else if counter == mediaFiles.count - 1 {
            counter = 0
        }
        if mediaFiles.count > 0 {
            mediaFiles.append(mediaFiles.removeFirst())
        }
    }
}
