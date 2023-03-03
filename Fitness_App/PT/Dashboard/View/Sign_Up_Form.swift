//
//  Sign_Up_Form.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-15.
//

import SwiftUI

struct Sign_Up_Form: View {
    
    @StateObject var EncodingJSON : encodingJSON = encodingJSON()
    @Binding var PT : PTModel
    @State private var showingImagePicker = false
    @State private var videoPickerIsPresented = false
    @State private var inputImage: [UIImage] = []
    @State private var videoURL: [String] = []
    @State private var  profImage : UIImage?
    //Error Alert
    let alertTitle: String = "Error"
    @State private var didError = true
    
    //For camera
    @State private var cameraIsPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    
    //TESTING START
    let PT_Mark = PTModel(name: "Mark Ruffalo", gender: "Male", phone: "123-456-789", email: "mark.ruffalo@gmail.com", experienceLevel: "Level 1", education: "Master's", Certification: "CanFit", gymLocation: .GoodLife, workoutTypes: .Calisthenic, Description: "Certified Trainer", Motto: "Traininig is Key!", PreferredGym: "GoodLife")
    //TESTING END
    
    var body: some View {
        ScrollView{
            Text("Sign up as a Trainer")
                .underline()
            Button("Add Profile Picture"){
                if profImage != nil {
                    Image(uiImage : profImage!)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            VStack(alignment: .center){
                profileSummary
                description
                IntroductionImages
                IntroductionVideo
                IDNCertifications
            }
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
                    TextField("Name", text: $PT.name)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                }

                //Gender
                HStack{
                        Text("Gender:")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    
                        Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    
                        TextField("Male", text: $PT.gender)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                }
                
                //Phone
                HStack{
                    Text("Phone #:")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Male", text: $PT.phone)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                }
                
                //Education
                HStack{
                    Text("Education")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Education", text: $PT.education)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
//                    TextField("Male", text: $PT.typesOfWorkOut)
    //                Picker() TODO: change to Picker or some type
                    
                }
               //Experience Level
                HStack{
                    Text("Experience Level")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Experience Level", text: $PT.experienceLevel)  // Needs to be Object
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                }
                //Training Category
                HStack{
                    Text("Training Category:")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Training Category:" , text: $PT.education)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                }
                //Certification
                HStack{
                    Text("Certification")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Certficates", text: $PT.Certification)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                }
                //Motto
                HStack{
                    Text("Motto")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Motto", text: $PT.Motto)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
    //                If you still look cute at the end of your workout, you didn't work hard enough
                }
                //Location
                HStack{
                    Text("Location")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    
                    TextField("Mississauga, ON", text: $PT.Motto)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                    // TODO: change to Picker or some type //$PT.gymLocation.rawValue
                }
                //Preferred Gyms
                HStack{
                    Text("Preferred Gyms")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Preferred Gyms", text: $PT.Motto)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                    //$PT.preferredGym.rawValue TODO: change to Picker or some type
                }
            }
           
        }
        
        var description: some View{
            VStack{
                //Description
                HStack{
                    Text("Description")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    TextField("Description", text: $PT.Description)
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.yellow)
                }
            }
        }
    
        //Finished
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
                        ImageView(uiImage: uiImage)
                    }
                //Inactive button
                    if inputImage.count == 3 {
                    ZStack{
                        Rectangle()
                            .fill(.gray)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                        
                        Button("+"){
                        }
                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
                        .background(.white)
                        .cornerRadius(12)
                    }
                    //Active buton
                } else if inputImage.count < 3 {
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
                            ImagePicker(image: $inputImage)
                        }
                    }
                }
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
                Text("Add up to 1 short video")
                    .frame(width: UIScreen.main.bounds.width/6)
                    .background(.yellow)
                
                if videoURL.count > 1 {
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
                            VideoPicker(videoURLs: $videoURL)
                        }
                    }
                }
            }
        }
        //Finished
        var IDNCertifications: some View{
                HStack{
                    Text("ID & Certifications:")
                        .frame(width: UIScreen.main.bounds.width/4)
                        .background(.blue)
                    Divider()
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/15)
                    VStack{
                        HStack{
                            Text("Upload a selfie. Certifications ")
                                .frame(width: UIScreen.main.bounds.width/2)
                                .background(.yellow)
                            //3-5 Image Thumbnails
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
                
//            submitting data to back-end
                Button(
                    "Submit",
                    action: {
                        encodingJSON.encode(users : user)
                    }
                )
                .foregroundColor(Color.purple)
                .cornerRadius(10)
            
        }
        
    
        func loadImage() {
//            guard let inputImage = inputImage else { return }
//       image = Image(uiImage: inputImage) // TO DO :hu
        }
    }



struct Sign_Up_Form_Previews: PreviewProvider {
    static var previews: some View {
        Sign_Up_Form(PT: .constant(PTModel(name: "hello", gender: "hello", phone: "hello", email: "hello", experienceLevel: "hello", education: "Hello", Certification: "hello", gymLocation: .GoodLife, workoutTypes: .Boxing, Description: "hello", Motto: "hello", PreferredGym: "hello")))
    }
}
