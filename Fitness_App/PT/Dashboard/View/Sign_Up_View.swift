//
//  Sign-Up View.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-07.
//

import SwiftUI

var gender = ["Male", "Female"]
var trainingCategory = ["Calisthenics", "General", "Weight Lifting", "Machine"]
var experienceLevel = ["Level 1", "Level 2", "Level 3"]
var educationLevel = ["Diploma", "Bachelor's", "Master's"]
var certification = ["CanFit", "Conditioning", "Competition"]
var location = ["Mississauga", "Toronto"]
var gymOption = ["Square One GoodLife", " Eaton Center GoodLife", "Toronto GoodLife"]

struct Sign_Up_View: View {
  
    @StateObject var modelData : ModelData = ModelData()
    @State var isEditing : Bool = false
    
    @State var selectedGender : TrainerGender = .m
    @State var selectedWorkOutCategory : typesOfWorkOut = .calisthenic
    @State var selectedExperience : PTexperienceLevel = .One
    @State var selectedEducation  : PTEducationLevel = .Diploma
    @State var selectedCertificate  : certificates = .CanFitProI
    @State var selectedLocation  : gymLocation = .Mississauga
    @State var selectedGym  : [gymPreferrence] = []
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
    
    //Error
    let alertTitle: String = "Error"
    @State private var didError = true
        
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    isEditing = isEditing ? false : true
                    if !isEditing{
                        //TODO: fetch from JSON
                        //TODO: Fix Figma.
                        //TODO: Add the stage for PT approval pending/rejected/approved=> Homepage() view for PT.
                    
            
                    }
                } label: {
                    Text(isEditing ? "Done" : "Edit")
                        .foregroundColor(.accentColor)
                }
            }
                
            
            Text("Your Profile")
                .underline()
            
            profileSummary
            profileImage
            IntroductionImages
            IntroductionVideo
            selfie
        }
    }
        
    var profileSummary: some View{
        VStack{
                HStack{
                    Text("Name:")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    
                    if isEditing{
                        TextField("Name", text: $PT.name) //PTModel
                            .frame(width: UIScreen.main.bounds.width/4)
                            .background(.yellow)
                    } else{
                        Text(PT.name)
                    }
                    
                }
                //Gender
                HStack{
                    if isEditing{
                        Picker("Gender", selection: $selectedGender){
                            ForEach(gender, id: \.self) {
                                Text($0)
                            }
                        }
                    } else{
                        Text(selectedGender.rawValue)
                    }
                }
                //Training Category
            Group{
                //Category 1
                HStack{
                    if isEditing{
                        Picker("Training Category", selection: $selectedWorkOutCategory){
                            ForEach(typesOfWorkOut.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    }else{
                        Text(selectedWorkOutCategory.rawValue)
                    }
                }
                //Category 2
                HStack{
                    if isEditing{
                        Picker("Training Category", selection: $selectedWorkOutCategory){
                            ForEach(typesOfWorkOut.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    }else{
                        Text(selectedWorkOutCategory.rawValue)
                    }
                }
                //Category 3
                HStack{
                    if isEditing{
                        Picker("Training Category", selection: $selectedWorkOutCategory){
                            ForEach(typesOfWorkOut.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                    }else{
                        Text(selectedWorkOutCategory.rawValue)
                    }
                }
            }
            
            //Experience Level
            HStack{
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
            
            //Education
            HStack{
                if isEditing{
                    Picker("Education", selection: $selectedEducation){
                        ForEach(PTEducationLevel.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                }else{
                    Text(selectedEducation.rawValue)
                }
            }
            //Certificates
            HStack{
                if isEditing{
                    Picker("Certification", selection: $selectedCertificate){
                        ForEach(certificates.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                }else{
                    Text(selectedCertificate.rawValue)
                }
            }
            
            //Motto
            //If you still look cute at the end of your workout, you didn't work hard enough
            VStack{
                Text("Motto:")
                    .frame(width: UIScreen.main.bounds.width/4)
                    .background(.blue)
               
                if isEditing{
                        TextFieldView(textInput: $PT.motto, placeholder: "Enter your unique motto here", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 200, height: 150)
                }else {
                    Text(PT.motto)
                }
            }
            
            //Current Location
            HStack{
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
            
            //Gym Preferrence
            //Gym1
            Group{
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
            //Description
                VStack{
                    Text("Description:")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                   
                    if isEditing{
                        TextFieldView(textInput: $PT.description, placeholder: "Enter your  descriptiojn here", isPassword: false, cornerRadius: 5, strokeColor: .secondary, strokeWidth: 1, width: 200, height: 150)
                    }else {
                        Text(PT.description)
                    }
            }
        }//VStack
    }
    
    var profileImage: some View{
        HStack{
            Text("Profile Image:")
//            Image("")
        }
    }
    
    //Finished TODO: line 290 and 288
    var IntroductionImages: some View{
        HStack{
            Text("Additional Images:")
                .frame(width: UIScreen.main.bounds.width/4)
                .background(.blue)
            Divider()
            Spacer()
                .frame(width: UIScreen.main.bounds.width/15)
            HStack{
                ForEach(inputImage, id: \.self){ uiImage in
                    ZStack{
                        ImageView(uiImage: uiImage)
                        VStack(alignment: .leading, spacing: 15){
                            HStack{
                                Spacer()
                                if isEditing{
                                    Button{
                                        inputImage.remove(atOffsets: <#T##IndexSet#>)
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
                    }   //zstack
                } //if
            }
        }
    }
    
    //Finished
    var IntroductionVideo: some View{
        HStack{
            Text("Introductory Video:")
                .frame(width: UIScreen.main.bounds.width/4)
                .background(.blue)
            Divider()
            Spacer()
                .frame(width: UIScreen.main.bounds.width/15)
            Text("Add up to 3 short video(s)")
                .frame(width: UIScreen.main.bounds.width/6)
                .background(.yellow)
            
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
                
            } else {
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                        .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                    
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
        }
    }
    
    //Finished
    var selfie: some View{
        HStack{
            Text("Portrait Photo:")
                .frame(width: UIScreen.main.bounds.width/4)
                .background(.blue)
            Divider()
            Spacer()
                .frame(width: UIScreen.main.bounds.width/15)
            VStack{
                HStack{
                    Text("Upload one selfie")
                        .frame(width: UIScreen.main.bounds.width/2)
                        .background(.yellow)
                    
                    Button(action: {
                        self.sourceType = .camera
                        self.cameraIsPresented = true
                    }, label: {
                        Label("Select", systemImage: "photo")
                    })
                }
                
                if let selectedImage = selectedImage{
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                }
            }
        }
        .sheet(isPresented: $cameraIsPresented){
            CameraView(selectedImage: $selectedImage, sourceType: self.sourceType)
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
