//
//  Sign-Up View.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-07.
//

import SwiftUI

////var gender = ["Male", "Female"]
//var trainingCategory = ["Calisthenics", "General", "Weight Lifting", "Machine"]
//var experienceLevel = ["Level 1", "Level 2", "Level 3"]
//var educationLevel = ["Diploma", "Bachelor's", "Master's"]
//var certficate = ["CanFit", "Conditioning", "Competition"]
//var location = ["Mississauga", "Toronto"]
//var gymOption = ["Square One GoodLife", " Eaton Center GoodLife", "Toronto GoodLife"]

struct Sign_Up_View: View {
    @State private var showImagePicker: Bool = false
    @State var isEditing : Bool = false
    @State var imageArray: [UIImage] = [UIImage(systemName: "person.fill")!]
    @State var user: PTModel

    @StateObject var ptVM = PTValidationModel()
    @EnvironmentObject var authVM : AuthViewModel
    
    //For Image/Video
    @State private var showingImagePicker = false
    @State private var videoPickerIsPresented = false
   
    
    //For Camera/Selfie
    @State private var cameraIsPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    
    @State private var phase = 0.0
    
    //Error
    let alertTitle: String = "Error"
    @State private var didError = true
    
    var body: some View {
        NavigationView{
        ScrollView{
            VStack{
                HStack{
                    Spacer()
                    Button{
                        isEditing = isEditing ? false : true
                        if !isEditing{
                            authVM.refreshPTData()
                        }
                    } label: {
                        Text(isEditing ? "Done" : "Edit")
                            .foregroundColor(.accentColor)
                    }
                }
                Text("Your Profile")
                    .underline()
                
                profileSummary
                IntroductionImages
                IntroductionVideo
                selfie
                
                
            }
            Text(ptVM.error)
                .foregroundColor(ptVM.error.isEmpty ? .clear : .red)
            
            if isEditing{
                
                Button{
                    var ptID: String
                    if authVM.currentUser == nil {
                        ptID = UUID().uuidString
                    } else {
                        ptID = authVM.currentUser!.uid
                    }
                    
                    ptVM.validateForm(ptID)
                } label:{
                    Text("Submit")
                        .bold()
                }
                
                .frame(width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.width/7)
                .background(Color.assetColor.pink)
                .foregroundColor(Color.assetColor.white)
                .cornerRadius(10)
                
            }
        }.onAppear{
            if let user = authVM.currentPTUser{
                self.user = user
                ptVM.populateStates(user)
            }
            
        }
        .navigationTitle("Fill Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    authVM.signOut()
                } label: {
                    Text("Sign Out")
                }
            }
        }
        .frame(width: (UIScreen.main.bounds.width - UIScreen.main.bounds.width/10))
            
        }
       
    }
    
    var profileSummary: some View{
        VStack(spacing: 10){
            GroupBox{

                //Profile Image
                HStack{
                    ptVM.profIMG[0].asProfileImage(100)
                        
                        .onTapGesture {
                            showImagePicker.toggle()
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $imageArray, selectionLimit: 1)
                        }
                        .onChange(of: imageArray[0]) { newValue in
                            var profIMGString : String = ""
                                // Changed to jpeg data to compress data size
                                guard let imageData = newValue.jpegData(compressionQuality: 0.09) else { return }
                                profIMGString = "data:image/jpeg;base64," + imageData.base64EncodedString()
                            ptVM.profIMG[0] = profIMGString
                          
                        }
                        .onAppear{
                            guard !user.isApproved  else { return }
                            guard let firebaseUser = authVM.currentUser else { return }
                            if ptVM.name.isEmpty {
                                ptVM.name = firebaseUser.displayName ?? ""
                            }
                            ptVM.phone = firebaseUser.phoneNumber ?? ""
                            ptVM.email = firebaseUser.email ?? ""
                            ptVM.profIMG[0] = firebaseUser.photoURL?.absoluteString ?? ""
                        }
                }
                
                //Name
                HStack{
                    Text("Name:")
    
                    Spacer()
                    
                    if isEditing{
                        TextFieldView(textInput: $ptVM.name, placeholder: "Name", isPassword: false, width: UIScreen.main.bounds.width/3)
                    } else{
                        Text(ptVM.name)
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width/9)
                    }
                }
                
                //email
                HStack{
                    Text("Email:")
                    
                    Spacer()
                    Group{
                        if isEditing{
                            TextFieldView(textInput: $ptVM.email, placeholder: "Email", isPassword: false, width: UIScreen.main.bounds.width/3)
                        } else{
                            Text(ptVM.email)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width/9)
                        }
                    }
                }
                //phone
                HStack{
                    Text("Phone:")
                    
                    Spacer()
                    
                    if isEditing{
                        TextFieldView(textInput: $ptVM.phone, placeholder: "Phone", isPassword: false, width: UIScreen.main.bounds.width/3)
                    } else{
                        Text(ptVM.phone)
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width/9)
                    }
                }
                
                //Gender
                HStack{
                    
                    Text("Gender:")
                    Spacer()
                    //Change to a Picker
                    if isEditing{
                        Picker("Gender", selection: $ptVM.gender) {
                            ForEach(TrainerGender.allCases, id: \.self) {
                                Text($0.rawValue)
//                                    .tag($0.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    } else{
                        Text(ptVM.gender.rawValue)
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width/9)
                        
                    }
                }
                
               
            }
            
            //Education
            GroupBox{
                //Education
                
                if isEditing{
                    StyledPicker(title: "Education") {
                        Picker("Education", selection: $ptVM.education){
                            ForEach(PTEducationLevel.allCases, id: \.self){
                                Text($0.rawValue)
//                                    .tag($0.rawValue)
                            }
                        }
                    }
                } else{
                    HStack{
                        Text("Education:")
                        Spacer()
                        Text(ptVM.education.rawValue)
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width/9)
                    }
                }
                Divider()
                //Certificates
                
                //                    Text("Certificates #1:")
                //                    Spacer()
//                HStack(alignment: .top){
//                    if !isEditing{
//                        Text("Certificate(s):")
//                            .padding(.trailing, 10)
//                        Spacer()
//                    }
//
//                VStack(alignment: .trailing){
                    
                    if isEditing{

                            StyledPicker(title: "certficate") {
                                Picker("Certficate(s)", selection: $ptVM.certificate[0]){
                                    ForEach(certificates.allCases, id: \.self){
                                        Text($0.rawValue)
                                            .tag($0.rawValue)
                                    }
                                }
                            }
//                            .navigationTitle("Certificate #1")
                    }else{
                        
                        HStack{
                            Text("Certificate(s):")
                                .padding(.trailing, 10)
                            Spacer()
                            Text(ptVM.certificate[0].rawValue)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width/9)
                        }
                    }
                
                HStack(alignment: .top){
                    Spacer()
                    VStack(alignment: .trailing){
                        
                    Divider()
                    .frame(width: UIScreen.main.bounds.width/3.5)
                        if isEditing{
                            StyledPicker(title: "certficate #2") {
                                Picker("", selection: $ptVM.certificate[1]){
                                    ForEach(certificates.allCases, id: \.self){
                                        Text($0.rawValue)
                                            .tag($0.rawValue)
                                    }
                                }
                            }
                        } else {
                            HStack{
                                Text(ptVM.certificate[1].rawValue)
                                Spacer()
                                    .frame(width: UIScreen.main.bounds.width/9)
                            }
                        }
                }
                .frame(width: UIScreen.main.bounds.width/3.5)
            }
            Divider()
                //Experience Level
                HStack{
                    if isEditing{
                        StyledPicker(title: "Experience Level") {
                            Picker("Experience Level", selection: $ptVM.experienceLevel){
                                ForEach(PTexperienceLevel.allCases, id: \.self){
                                    Text($0.rawValue)
                                        .tag($0.rawValue)
                                }
                            }
                        }
                    }else{
                        Text("Experience Level:")
                        Spacer()
                        Text(ptVM.experienceLevel.rawValue)
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width/9)
                    }
                }
            }
            
            //Gym Preferrence : 3 categories
            GroupBox{
                //Current Location
                    if isEditing{
                        StyledPicker(title: "City") {
                            Picker("Gym Location", selection: $ptVM.city){
                                ForEach(gymLocation.allCases, id: \.self){
                                    Text($0.rawValue)
                                }
                            }
                        }
                    }else{
                        HStack{
                            Text("City:")
                            Spacer()
                            Text(ptVM.city.rawValue)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width/9)
                        }
                    }
                
                Divider()
                //Gym1
                HStack(alignment: .top){
                    Text("Gym(s):")
                        .foregroundColor(isEditing ? .blue : .black)
                        .padding(.trailing, 10)
                    Spacer()
                    VStack(alignment: .trailing){
                        //Gym 1
                        if isEditing{
                            StyledPicker(title: "Gym #1:") {
                                Picker("", selection: $ptVM.gymPreferencePublished[0]){
                                    ForEach(gymPreferrence.allCases, id: \.self){
                                        Text($0.rawValue)
                                    }
                                }
                            }
                        }else{
                            HStack{
                                Text(ptVM.gymPreferencePublished[0].rawValue)
                                Spacer()
                                    .frame(width: UIScreen.main.bounds.width/9)
                            }
                        }
                        
                        Divider()
                        //Gym2
                        if isEditing{
                            StyledPicker(title: "Gym #2") {
                                Picker("", selection: $ptVM.gymPreferencePublished[1]){
                                    ForEach(gymPreferrence.allCases, id: \.self){
                                        Text($0.rawValue)
                                    }
                                }
                            }
                        }else{
                            HStack{
                                Text(ptVM.gymPreferencePublished[1].rawValue)
                                Spacer()
                                    .frame(width: UIScreen.main.bounds.width/9)
                            }
                        }
                        
                        Divider()
                   
                        //Gym3
                            if isEditing{
                                StyledPicker(title: "Gym #2") {
                                    Picker("", selection: $ptVM.gymPreferencePublished[2]){
                                        ForEach(gymPreferrence.allCases, id: \.self){
                                            Text($0.rawValue)
                                        }
                                    }
                                }
                            }else{
                                HStack{
                                    Text(ptVM.gymPreferencePublished[2].rawValue)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.width/9)
                                }
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width/3.5)
                }
            }
            
            //Training Category : 3 categories
            GroupBox{
                HStack(alignment: .top){
                   
                    Text("Training Category(ies):")
                        .foregroundColor(isEditing ? .blue : .black)
                        .padding(.trailing, 10)
                        .frame(width: UIScreen.main.bounds.width/3)
                        .lineLimit(2)
                    Spacer()
                    VStack(alignment: .trailing){
                        //Category 1
                        HStack{
                            if isEditing{
                                StyledPicker(title: "Category #1") {
                                    Picker("", selection: $ptVM.typeOfExercise[0]){
                                        ForEach(typesOfWorkOut.allCases, id: \.self){
                                            Text($0.rawValue)
                                        }
                                    }
                                }
                            } else {
                                HStack{
//                                    Text("Category #1:")
//                                    Spacer()
                                    Text(ptVM.typeOfExercise[0].rawValue)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.width/9)
                                }
                            }
                        }
                        Divider()
                        //Category 2
                        HStack{
                            if isEditing{
                                StyledPicker(title: "Category #2") {
                                    Picker("", selection: $ptVM.typeOfExercise[1]){
                                        ForEach(typesOfWorkOut.allCases, id: \.self){
                                            Text($0.rawValue)
                                               
                                            
                                        }
                                    }
                                }
                            }else{
                                HStack{
//                                    Text("Category #2:")
//                                    Spacer()
                                    Text(ptVM.typeOfExercise[1].rawValue)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.width/9)
                                }
                            }
                        }
                        Divider()
                        
                        //Category 3
                            if isEditing{
                                StyledPicker(title: "Category #3") {
                                    Picker("", selection: $ptVM.typeOfExercise[2]){
                                        ForEach(typesOfWorkOut.allCases, id: \.self){
                                            Text($0.rawValue)
                                        }
                                    }
                                }
                            }else{
                                HStack{
                                    Text(ptVM.typeOfExercise[2].rawValue)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.width/9)
                                }
                            }
                        
                        }
                    .frame(width: UIScreen.main.bounds.width/3.5)
                }
            }
          

            //Motto,Description
            //If you still look cute at the end of your workout, you didn't work hard enough
            GroupBox{
                HStack{
                    Text("Motto:")
                    Spacer()
                }
                if isEditing{
                    TextFieldView(textInput: $ptVM.motto, placeholder: "Enter your unique motto here", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, offsetX:0, width: (UIScreen.main.bounds.width - UIScreen.main.bounds.width/5), height: 150, isLong: true)
                    
                } else {
                    Text(ptVM.motto)
                }
                
                //Description
                VStack{
                    HStack{
                        Text("Description:")
                        Spacer()
                    }
                    
                    if isEditing{
                        TextFieldView(textInput: $ptVM.description, placeholder: "Enter your  description here", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, offsetX:0, width: (UIScreen.main.bounds.width - UIScreen.main.bounds.width/5), height: 150, isLong: true)
                        
                    }else {
                        Text(ptVM.description)
                            .frame(alignment: .leading)
                    }
                } //VStack
            }
        }
    }
    
    //Images TODO: line 290 and 288
    var IntroductionImages: some View{
        GroupBox{
            HStack{
                Text("Images:")
                Divider()
                Spacer()
                VStack{
                    if ptVM.inputImage.count < 4 {
                        Text("Add up to 3  image(s)")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                    }
                    HStack{
                        ForEach(ptVM.inputImage, id: \.self){ uiImage in
                            ZStack{
                                ImageView(uiImage: uiImage)
                                VStack(alignment: .leading, spacing: 15){
                                    HStack{
                                        Spacer()
                                        if isEditing{
                                            Button{
                                                guard let index = ptVM.inputImage.firstIndex(of: uiImage) else { return }
                                                ptVM.inputImage.remove(at: index)
                                            } label: {
                                                Image(systemName: "delete.left.fill")
                                            }
                                        }
                                    }
                                }
                            }
                            
                            .border(.purple)
                        }
                        //Button
                        if (isEditing) && (ptVM.inputImage.count < 3) {
                            ZStack{
                                Rectangle()
                                    .fill(.secondary)
                                    .frame(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.width/6)
                                    .cornerRadius(12)
                                
                                Button("+"){
                                    showingImagePicker = true
                                    loadImage()
                                }
                                .onChange(of: ptVM.inputImage) { _ in loadImage() }
                                .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
                                .background(.white)
                                .cornerRadius(12)
                                .sheet(isPresented: $showingImagePicker) {
                                    ImagePicker(image: $ptVM.inputImage, selectionLimit: 3)
                                }
                            }
                        }
                        else if (isEditing) && (ptVM.inputImage.count == 3){
                            EmptyView()
                        } else if  !isEditing && (ptVM.inputImage.count == 0){
                            HStack{
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                    .foregroundColor(.purple)
                                    .frame(width: 40, height: 40)
                                Spacer()
                                    .frame(width: UIScreen.main.bounds.width/15)
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                    .foregroundColor(.purple)
                                    .frame(width: 40, height: 40)
                                Spacer()
                                    .frame(width: UIScreen.main.bounds.width/15)
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                    .foregroundColor(.purple)
                                    .frame(width: 40, height: 40)
                                Spacer()
                                    .frame(width: UIScreen.main.bounds.width/15)
                            }
                        } else if !isEditing  && ( 1 <= ptVM.inputImage.count) && (ptVM.inputImage.count < 3){
                            let imagesLeft = 3 - ptVM.inputImage.count
                            Text("You need \(imagesLeft) more images.")
                        }
                        
                    }
                }
            }
        }
    }
    
    //Video
    var IntroductionVideo: some View{
        GroupBox{
            HStack{
                Text("Video:")
                Divider()
                Spacer()
                VStack{
                    Text("Add up to 1 short video(s)")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                    
                    if ptVM.videoURL.count > 3 {
                        Text("")
                            .alert(
                                Text(alertTitle),
                                isPresented: $didError
                            ) {
                                Button("OK") {
                                    // Dismisses the Error Window
                                }
                            } message: {
                                Text("No more than one video")
                            }
                    }
                    //Video-View
                    ForEach(ptVM.videoURL, id: \.self){video in
                        ZStack{
                            Image(uiImage:  imageFromVideo(url: URL(string: video) ?? URL(string: "https://www.google.com")! , at: 1) ?? UIImage(systemName: "play.circle")!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width/6.5, height: UIScreen.main.bounds.width/6.5)
                            
//                            HStack{
//                                Spacer()
//                                VStack{
//                                    Image(systemName: "circle")
//                                        .foregroundColor(Color.assetColor.red)
//                                    Spacer()
//                                }
//
//                            }.frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.width/6)
                            
                            VStack(alignment: .leading, spacing: 15){
                                HStack(alignment: .top){
                                    Spacer()
                                    if isEditing{
                                        Button{
                                            guard let index = ptVM.videoURL.firstIndex(of: video) else { return }
                                            ptVM.videoURL.remove(at: index)
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(Color.assetColor.red)
                                                
                                            
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }.frame(width: UIScreen.main.bounds.width/4.5, height: UIScreen.main.bounds.width/4.5)
//                            .border(.purple)
                        
                    }
                    if isEditing{
                        
                        ZStack{
                            Rectangle()
                                .fill(.secondary)
                                .frame(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.width/6)
                                .cornerRadius(12)
                            
                            
                            Button("+"){
                                videoPickerIsPresented = true
                                loadImage()
                            }
                            .onChange(of: ptVM.videoURL) { _ in loadImage() }
                            .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
                            .background(.white)
                            .cornerRadius(12)
                            .sheet(isPresented: $videoPickerIsPresented) {
                                VideoPicker(videoURLs: $ptVM.videoURL, selectionLimit: 1)
                            }
                        }
                }
                    else{
                        HStack{
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                .foregroundColor(.purple)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width/15)
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                .foregroundColor(.purple)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width/15)
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                .foregroundColor(.purple)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width/15)
                        }
                        
                    }
                }//VStack
            }
        }//GroupBox
    }
    
    //Portrait Photo
    var selfie: some View{
        GroupBox{
            HStack{
                Text("Portrait Photo:")
                Divider()
                Spacer()
                VStack{
                    Text("Upload 1 selfie")
                        .font(.system(size: 10))
                    if isEditing{
                        Button(action: {
                            self.sourceType = .camera
                            self.cameraIsPresented = true
                        }, label: {
                            Label("Select", systemImage: "photo")
                        })
                        
                        if let selectedImage = ptVM.selectedImage{
                            Image(uiImage: selectedImage)
                                .resizable()
                                .frame(width: 150, height: 150)
                           
                        }
                      
                    } else{
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                            .foregroundColor(.purple)
                            .frame(width: 50, height: 25)
                        
                    }
                }
            }
                .sheet(isPresented: $cameraIsPresented){
                    CameraView(selectedImage: $ptVM.selectedImage, sourceType: self.sourceType)
            }
        }
    }
    
    func loadImage() {
//            guard let inputImage = inputImage else { return }
//       image = Image(uiImage: inputImage) // TO DO :hu
    }
    
}
//TODO: Neeeds work
//struct Sign_Up_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Sign_Up_View(PT: PTModel(id: "1001", name: "Hello", gender: "Hello", phone: "Hello", email: "Hello", experienceLevel: "Hello", education: "Hello", certficate: "Hello", city: "Mississauga", isFeatured: true, isFavorite: false, description: "Hello", motto: "Gym", profileImg: "Hello", gymLocation: "Mississauga", workoutTypes: typesOfWorkOut.calisthenic ?? typesOfWorkOut , gymPreference: gymPreferrence(rawValue: "GoodLife") ?? gymPreferrence.GoodLife ))
//    }
//}
