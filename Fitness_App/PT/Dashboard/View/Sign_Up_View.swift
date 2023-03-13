//
//  Sign-Up View.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-07.
//

import SwiftUI

//var gender = ["Male", "Female"]
var trainingCategory = ["Calisthenics", "General", "Weight Lifting", "Machine"]
var experienceLevel = ["Level 1", "Level 2", "Level 3"]
var educationLevel = ["Diploma", "Bachelor's", "Master's"]
var certification = ["CanFit", "Conditioning", "Competition"]
var location = ["Mississauga", "Toronto"]
var gymOption = ["Square One GoodLife", " Eaton Center GoodLife", "Toronto GoodLife"]

struct Sign_Up_View: View {
    
    //    @StateObject var modelData : ModelData = ModelData()
    @State var isEditing : Bool = false
    
    @State var selectedGender : String = "Male"
    @State var selectedWorkOutCategory : [typesOfWorkOut] = [.calisthenic, .americanBoxing, .weights]
    @State var selectedExperience : PTexperienceLevel = .One
    @State var selectedEducation  : PTEducationLevel = .Diploma
    @State var selectedCertificate  : [certificates] = [.CanFitProI, .CanFitProII]
    @State var selectedLocation  : gymLocation = .Mississauga
    @State var selectedGym  : [gymPreferrence] = [.GoodLife, .FitnessPlanet, .UFC]
    @State var PT : PTModel
    @EnvironmentObject var authVM : AuthViewModel
    
    //For Image/Video
    @State private var showingImagePicker = false
    @State private var videoPickerIsPresented = false
    @State private var inputImage: [UIImage] = []
    @State private var videoURL: [String] = []
    @State private var  profImage : UIImage?
    
    
    //For Camera/Selfie
    @State private var cameraIsPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    
    @State private var phase = 0.0
    @StateObject var ptVM = PTValidationModel()
    
    //Error
    let alertTitle: String = "Error"
    @State private var didError = true
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Spacer()
                    Button{
                        isEditing = isEditing ? false : true
                        if !isEditing{
                            //TODO: fetch from JSON.
                            //TODO: Add the stage for PT approval pending/rejected/approved=> Homepage() view for PT.
                            //TODO: encodinig and decoding data and images
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
            if isEditing{
                Button{
                    ptVM.validateForm()
                } label:{
                    Text("Submit")
                }
                .foregroundColor(Color.purple)
                .cornerRadius(10)
                
            }
        }.frame(width: (UIScreen.main.bounds.width - UIScreen.main.bounds.width/10))
    }
    
    var profileSummary: some View{
        VStack(spacing: 10){
            GroupBox{
                //Name
                HStack{
                    Text("Name:")
                    
                    Spacer()
                    
                    if isEditing{
                        TextField("Name", text: $PT.name) //PTModel
                            .frame(width: UIScreen.main.bounds.width/5)
                            .border(.purple, width: 2)
                    } else{
                        Text(PT.name)
                    }
                }
                
                //Gender
                HStack{
                    
                    Text("Gender:")
                    Spacer()
                    
                    if isEditing{
                        TextField("Gender", text: $selectedGender) //PTModel
                            .frame(width: UIScreen.main.bounds.width/4)
                            .border(.purple, width: 2)
                    } else{
                        Text(selectedGender)
                    }
                }
                
                //Current Location
                HStack{
                    Text("City:")
                    Spacer()
                    
                    if isEditing{
                        Picker("Gym Location", selection: $selectedLocation){
                            ForEach(gymLocation.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    }else{
                        Text(selectedLocation.rawValue)
                    }
                }
            }
            
            //Gym Preferrence : 3 categories
            GroupBox{
                HStack(alignment: .top){
                    Text("Gym(s):")
                        .padding(.trailing, 10)
                    Spacer()
                    VStack(alignment: .trailing){
                        //Gym 1
                        HStack{
                            if isEditing{
                                Picker("Preferred Gym", selection: $selectedGym[0]){
                                    ForEach(gymPreferrence.allCases, id: \.self){
                                        Text($0.rawValue)
                                    }
                                }
                            }else{
                                Text(selectedGym[0].rawValue)
                            }
                        }
                        Divider()
                        //                            .frame(width: UIScreen.main.bounds.width/4)
                        //Gym2
                        HStack{
                            if isEditing{
                                Picker("Preferred Gym", selection: $selectedGym[1]){
                                    ForEach(gymPreferrence.allCases, id: \.self){
                                        Text($0.rawValue)
                                    }
                                }
                            }else{
                                Text(selectedGym[1].rawValue)
                            }
                        }
                        Divider()
                        //                            .frame(width: UIScreen.main.bounds.width/4)
                        //Gym3
                        HStack{
                            
                            
                            if isEditing{
                                Picker("Preferred Gym", selection: $selectedGym[2]){
                                    ForEach(gymPreferrence.allCases, id: \.self){
                                        Text($0.rawValue)
                                    }
                                }
                            }else{
                                Text(selectedGym[2].rawValue)
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/3.5)
                }
            }
            
            //Training Category : 3 categories
            GroupBox{
                HStack(alignment: .top){
                    Text("Category(ies):")
                    Spacer()
                    
                    VStack(alignment: .trailing){
                        //Category 1
                        HStack{
                            if isEditing{
                                Picker("Training Category", selection: $selectedWorkOutCategory[0]){
                                    ForEach(typesOfWorkOut.allCases, id: \.self){
                                        Text($0.rawValue)
                                    }
                                }
                            }else{
                                Text(selectedWorkOutCategory[0].rawValue)
                            }
                        }
                        Divider()
                        //Category 2
                        HStack{
                            
                            if isEditing{
                                Picker("Training Category", selection: $selectedWorkOutCategory[1]){
                                    ForEach(typesOfWorkOut.allCases, id: \.self){
                                        Text($0.rawValue)
                                            .font(.system(size: 15))
                                        
                                    }
                                }
                            }else{
                                Text(selectedWorkOutCategory[1].rawValue)
                            }
                        }
                        Divider()
                        //Category 3
                        HStack{
                            
                            if isEditing{
                                Picker("Training Category", selection: $selectedWorkOutCategory[2]){
                                    ForEach(typesOfWorkOut.allCases, id: \.self){
                                        Text($0.rawValue)
                                    }
                                }
                            }else{
                                Text(selectedWorkOutCategory[2].rawValue)
                            }
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width/3.5)
                }
            }
            GroupBox{
                
                //Education
                HStack{
                    Text("Education:")
                    Spacer()
                    
                    if isEditing{
                        Picker("Education", selection: $selectedEducation){
                            ForEach(PTEducationLevel.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    } else{
                        Text(selectedEducation.rawValue)
                    }
                }
                //Certificates
                HStack{
                    Text("Certificates:")
                    Spacer()
                    
                    if isEditing{
                        Picker("Certification", selection: $selectedCertificate){
                            ForEach(certificates.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    }else{
                        Text(selectedCertificate[0].rawValue)
                    }
                }
                //Experience Level
                HStack{
                    Text("Experience Level:")
                    Spacer()
                    
                    if isEditing{
                        Picker("Experience Level", selection: $selectedExperience){
                            ForEach(PTexperienceLevel.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    }else{
                        Text(selectedExperience.rawValue)
                    }
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
                    TextFieldView(textInput: $PT.motto, placeholder: "Enter your unique motto here", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: (UIScreen.main.bounds.width - UIScreen.main.bounds.width/5), height: 150)
                }else {
                    Text(PT.motto)
                }
                
                //Description
                VStack{
                    HStack{
                        Text("Description:")
                        Spacer()
                    }
                    
                    if isEditing{
                        TextFieldView(textInput: $PT.description, placeholder: "Enter your  description here", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: (UIScreen.main.bounds.width - UIScreen.main.bounds.width/5), height: 150)
                            .frame(alignment: .leading)
                        
                    }else {
                        Text(PT.description)
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
                    if inputImage.count < 4 {
                        Text("Add up to 3  image(s)")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                    }
                    HStack{
                        ForEach(inputImage, id: \.self){ uiImage in
                            ZStack{
                                ImageView(uiImage: uiImage)
                                VStack(alignment: .leading, spacing: 15){
                                    HStack{
                                        Spacer()
                                        if isEditing{
                                            Button{
                                                guard let index = inputImage.firstIndex(of: uiImage) else { return }
                                                inputImage.remove(at: index)
                                            } label: {
                                                Image(systemName: "delete.left.fill")
                                            }
                                        }
                                    }
                                }
                            }
                            .border(.purple)
                        }
                        //Active button
                        if (isEditing) && (inputImage.count < 4) {
                            ZStack{
                                Rectangle()
                                    .fill(.secondary)
                                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                                    .cornerRadius(12)
                                
                                Button("+"){
                                    showingImagePicker = true
                                    loadImage()
                                }
                                .onChange(of: inputImage) { _ in loadImage() }
                                .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
                                .background(.white)
                                .cornerRadius(12)
                                .sheet(isPresented: $showingImagePicker) {
                                    ImagePicker(image: $inputImage, selectionLimit: 3)
                                }
                            }
                        } else if  !isEditing && (inputImage.count == 0){
                            HStack{
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                    .foregroundColor(.purple)
                                    .frame(width: 40, height: 40)
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                    .foregroundColor(.purple)
                                    .frame(width: 40, height: 40)
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                    .foregroundColor(.purple)
                                    .frame(width: 40, height: 40)
                            }
                        } else if !isEditing  && ( 1 <= inputImage.count) && (inputImage.count < 3){
                            var imagesLeft = 3 - inputImage.count
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
                    Text("Add up to 3 short video(s)")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                    
                    if videoURL.count > 4 {
                        Text("")
                            .alert(
                                Text(alertTitle),
                                isPresented: $didError
                            ) {
                                Button("OK") {
                                    // Dismisses the Error Window
                                }
                            } message: {
                                Text("No more than three video")
                            }
                    }
                    
                    if isEditing{
                        
                        ZStack{
                            Rectangle()
                                .fill(.secondary)
                                .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                                .cornerRadius(12)
                            
                            
                            Button("+"){
                                videoPickerIsPresented = true
                                loadImage()
                            }
                            .onChange(of: videoURL) { _ in loadImage() }
                            .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
                            .background(.white)
                            .cornerRadius(12)
                            .sheet(isPresented: $videoPickerIsPresented) {
                                VideoPicker(videoURLs: $videoURL, selectionLimit: 3)
                            }
                        }
                }
                    else{
                        HStack{
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                .foregroundColor(.purple)
                                .frame(width: 40, height: 40)
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                .foregroundColor(.purple)
                                .frame(width: 40, height: 40)
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
                                .foregroundColor(.purple)
                                .frame(width: 40, height: 40)
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
                        
                        if let selectedImage = selectedImage{
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
                    CameraView(selectedImage: $selectedImage, sourceType: self.sourceType)
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
//        Sign_Up_View(PT: PTModel(id: "1001", name: "Hello", gender: "Hello", phone: "Hello", email: "Hello", experienceLevel: "Hello", education: "Hello", certification: "Hello", city: "Mississauga", isFeatured: true, isFavorite: false, description: "Hello", motto: "Gym", profileImg: "Hello", gymLocation: "Mississauga", workoutTypes: typesOfWorkOut.calisthenic ?? typesOfWorkOut , gymPreference: gymPreferrence(rawValue: "GoodLife") ?? gymPreferrence.GoodLife ))
//    }
//}
