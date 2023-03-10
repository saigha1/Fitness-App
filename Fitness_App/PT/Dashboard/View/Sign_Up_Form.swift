////
////  Sign_Up_Form.swift
////  Fitness_App
////
////  Created by MAC on 2023-02-15.
////
//
//import SwiftUI
//
//struct Sign_Up_Form: View {
//    @StateObject private var PTValidationVM = PTValidationModel()
//    @StateObject var EncodingJSON : encodingJSON = encodingJSON()
//    @Binding var PT : PTModel
//    @State private var showingImagePicker = false
//    @State private var videoPickerIsPresented = false
//    @State private var inputImage: [UIImage] = []
//    @State private var videoURL: [String] = []
//    @State private var  profImage : UIImage?
//    //Error Alert
//    let alertTitle: String = "Error"
//    @State private var didError = true
//
//    //For camera
//    @State private var cameraIsPresented = false
//    @State private var sourceType: UIImagePickerController.SourceType = .camera
//    @State private var selectedImage: UIImage?
//
//    @StateObject var vm = PTValidationModel()
//
//    var body: some View {
//        ScrollView{
//            Text("Sign up as a Trainer")
//                .underline()
//            Button("Add Profile Picture"){
//                if profImage != nil {
//                    Image(uiImage : profImage!)
//                        .resizable()
//                        .frame(width: 250, height: 250)
//                        .aspectRatio(contentMode: .fit)
//                }
//            }
//
//            VStack(alignment: .center){
//                profileSummary
//                description
//                IntroductionImages
//                IntroductionVideo
//                IDNCertifications
//            }
//
////            submitting data to back-end
//            Button(
//                "Submit",
//                action: {
//                    vm.validateForm()
//                }
//            )
//            .foregroundColor(Color.purple)
//            .cornerRadius(10)
//        }
//    }
//
//        var profileSummary: some View{
//            VStack{
//                //Name
//                HStack{
//                    Text("Name:")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Name", text: $PT.name) //PTModel
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                }
//
//                //Gender
//                HStack{
//                    Text("Gender:")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//
//                    TextField("Male", text: $PT.gender)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                }
//
//                //Phone
//                HStack{
//                    Text("Phone #:")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Male", text: $PT.phone)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                }
//
//                //Education
//                HStack{
//                    Text("Education")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Education", text: $PT.education)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//
//                }
//
//                //WorkoutTypes
//                Group {
//                    HStack {
//                        Text("Workout Type 1")
//                        Spacer()
//                        Picker("Workout Type 1", selection: $PTValidationVM.typeOfExercise[0]) {
//                            ForEach(PTValidationVM.workoutTypesSelectable(0), id: \.self) {
//                                Text($0.rawValue)
//                                    .tag("wotype1")
//                            }
//                        }
//                    }
//                    HStack {
//                        Text("Workout Type 2")
//                        Spacer()
//                        Picker("Workout Type 2", selection: $PTValidationVM.typeOfExercise[1]) {
//                            ForEach(PTValidationVM.workoutTypesSelectable(1), id: \.self) {
//                                Text($0.rawValue)
//                                    .tag("wotype2")
//                            }
//                        }}
//                    HStack {
//                        Text("Workout Type 3")
//                        Spacer()
//                        Picker("Workout Type 3", selection: $PTValidationVM.typeOfExercise[2]) {
//                            ForEach(PTValidationVM.workoutTypesSelectable(2), id: \.self) {
//                                Text($0.rawValue)
//                                    .tag("wotype3")
//                            }
//                        }
//                    }
//                }
//
//                //Experience Level
//                HStack{
//                    Text("Experience Level")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Experience Level", text: $PT.experienceLevel)  // Needs to be Object
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                }
//                //Training Category
//                HStack{
//                    Text("Training Category:")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Training Category:" , text: $PT.education)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                }
//
//                //Certification
//                HStack{
//                    Text("Certification")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Certficates", text: $PT.certification)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                }
//                //Motto
//                HStack{
//                    Text("Motto")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Motto", text: $PT.motto)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                    //                If you still look cute at the end of your workout, you didn't work hard enough
//                }
//            }
//
//        }
//
//        var description: some View{
//            VStack{
//                //City
//                HStack{
//                    Text("City")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//
//                    TextField("Mississauga, ON", text: $PT.city)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                    // TODO: change to Picker or some type //$PT.gymLocation.rawValue
//                }
//                //Preferred Gyms
//                HStack{
//                    Text("Preferred Gyms")
//                        .frame(width: UIScreen.main.bounds.width/4)
//
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//
//                    Picker("Preferred Gym", selection: $PTValidationVM.gymPreferencePublished) {
//                        ForEach(gymPreferrence.allCases, id: \.self) { gym in
//                            Text(gym.rawValue.capitalized)
//                        }
//                    }
//                    .frame(width: UIScreen.main.bounds.width/4)
//                    .background(.yellow)
//            }
//                //Description
//                HStack{
//                    Text("Description")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    TextField("Description", text: $PT.description)
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.yellow)
//                }
//            }
//        }
//
//        //Finished
//        var IntroductionImages: some View{
//            HStack{
//                Text("Additional Images:")
//                    .frame(width: UIScreen.main.bounds.width/4)
//                    .background(.blue)
//                Divider()
//                Spacer()
//                    .frame(width: UIScreen.main.bounds.width/15)
//                HStack{
//                    ForEach(inputImage, id: \.self){ uiImage in
//                        ImageView(uiImage: uiImage)
//                    }
//                //Inactive button
//                    if inputImage.count == 3 {
//                    ZStack{
//                        Rectangle()
//                            .fill(.gray)
//                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
//
//                        Button("+"){
//                        }
//                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
//                        .background(.white)
//                        .cornerRadius(12)
//                    }
//                    //Active buton
//                } else if inputImage.count < 3 {
//                    ZStack{
//                        Rectangle()
//                            .fill(.secondary)
//                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
//
//                        Button("+"){
//                            showingImagePicker = true
//                            loadImage()
//                        }
//                        .onChange(of: inputImage) { _ in loadImage() }
//                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
//                        .background(.white)
//                        .cornerRadius(12)
//                        .sheet(isPresented: $showingImagePicker) {
//                            ImagePicker(image: $inputImage)
//                        }
//                    }
//                }
//                }
//            }
//        }
//
//        //Finished
//        var IntroductionVideo: some View{
//            HStack{
//                Text("Introductory Video:")
//                    .frame(width: UIScreen.main.bounds.width/4)
//                    .background(.blue)
//                Divider()
//                Spacer()
//                    .frame(width: UIScreen.main.bounds.width/15)
//                Text("Add up to 1 short video")
//                    .frame(width: UIScreen.main.bounds.width/6)
//                    .background(.yellow)
//
//                if videoURL.count > 1 {
//                    Text("")
//                        .alert(
//                            Text(alertTitle),
//                            isPresented: $didError
//                        ) {
//                            Button("OK") {
//                                // Dismisses the Error Window
//                            }
//                        } message: {
//                           Text("No more than one video")
//                        }
//
//                } else {
//                    ZStack{
//                        Rectangle()
//                            .fill(.secondary)
//                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
//
//                        Button("+"){
//                            videoPickerIsPresented = true
//                            loadImage()
//                        }
//                        .onChange(of: videoURL) { _ in loadImage() }
//                        .frame(width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
//                        .background(.white)
//                        .cornerRadius(12)
//                        .sheet(isPresented: $videoPickerIsPresented) {
//                            VideoPicker(videoURLs: $videoURL)
//                        }
//                    }
//                }
//            }
//        }
//        //Finished
//        var IDNCertifications: some View{
//                HStack{
//                    Text("ID & Certifications:")
//                        .frame(width: UIScreen.main.bounds.width/4)
//                        .background(.blue)
//                    Divider()
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width/15)
//                    VStack{
//                        HStack{
//                            Text("Upload a selfie. Certifications ")
//                                .frame(width: UIScreen.main.bounds.width/2)
//                                .background(.yellow)
//                            //3-5 Image Thumbnails
//                            Button(action: {
//                                self.sourceType = .camera
//                                self.cameraIsPresented = true
//                            }, label: {
//                                Label("Select", systemImage: "photo")
//                            })
//                        }
//                        if let selectedImage = selectedImage{
//                            Image(uiImage: selectedImage)
//                                .resizable()
//                                .frame(width: 150, height: 150)
//
//                        }
//                    }
//                }
//                .sheet(isPresented: $cameraIsPresented){
//                    CameraView(selectedImage: $selectedImage, sourceType: self.sourceType)
//                }
//        }
//        func loadImage() {
////            guard let inputImage = inputImage else { return }
////       image = Image(uiImage: inputImage) // TO DO :hu
//        }
//    }
//
//
//
////struct Sign_Up_Form_Previews: PreviewProvider {
////    static var previews: some View {
////        Sign_Up_Form(, PT: <#Binding<PTModel>#>)
////    }
////}
////PT: .constant(PTModel(name: "hello", gender: "hello", phone: "hello", email: "hello", experienceLevel: "hello", education: "Hello", Certification: "hello", gymLocation: .GoodLife, workoutTypes: .Boxing, Description: "hello", Motto: "hello", PreferredGym: "hello"))
