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
    var isEditing : Bool = false
    @State var selectedGender : String = "Male"
    @State var selectedCategory : String = "Calisthentics"
    @State var selectedExperience : String = "Level 1"
    @State var selectedEducation  : String = "Diploma"
    @State var selectedCertificate  : String = "CanFit"
    @State var selectedLocation  : String = "Mississauga"
    @State var selectedGym  : String = "Square One GoodLife"
    var PT : PTModel
    
//    @StateObject var EncodingJSON : encodingJSON = encodingJSON()
 
//    var user : [EndUserModel] = [EndUserModel(id: <#T##Int#>, name: <#T##String?#>, phone: <#T##Int?#>, email: <#T##String?#>, preferredTrainerGender: <#T##String#>, gymLocation: <#T##String#>)]
    
    //TODO: Delete.
//    @State var endUserName : String?
//    @State var name : String
//    @State var gender : String
//    @State var TrainingCategory : String
//    @State var ExperienceLevel : String
//    @State var Education : String
//    @State var Certification : String
//    @State var Location : String
//    @State var PreferredGyms : String
//    @State var Description : String
//    @State var Motto : String
//
        
    var body: some View {
        VStack{
            Text("Your Profile")
                .underline()
            
                    profileSummary
                    profileImage
                    IntroductionImages
                    IntroductionVideo
                    IDNCertifications
                }
            }
        
    

    var profileSummary: some View{
        VStack{
            HStack{ //No HStack. add padding.
//                    Text(user.name)
                    Text("Name")
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
                    Text("\(selectedGender)")
                }
            }
            //Training Category
            HStack{
                if isEditing{
                    Picker("Training Category", selection: $selectedCategory){
                        ForEach(trainingCategory, id: \.self){
                            Text($0)
                        }
                    }
                }else{
                    Text("\(selectedCategory)")
                }
            }
            //Experience Level
            HStack{
                if isEditing{
                    Picker("Experience Level", selection: $selectedExperience){
                        ForEach(trainingCategory, id: \.self){
                            Text($0)
                        }
                    }
                }else{
                    Text("\(selectedCategory)")
                }
            }
            //Education
            HStack{
                if isEditing{
                    Picker("Education", selection: $selectedEducation){
                        ForEach(educationLevel, id: \.self){
                            Text($0)
                        }
                    }
                }else{
                    Text("\(selectedEducation)")
                }
            }
            //Certificates
            HStack{
                if isEditing{
                    Picker("Certification", selection: $selectedCertificate){
                        ForEach(certification, id: \.self){
                            Text($0)
                        }
                    }
                }else{
                    Text("\(selectedCertificate)")
                }
            }
            //Motto
            //If you still look cute at the end of your workout, you didn't work hard enough
            HStack{
                Text("Motto: \(PT.Motto)")
                
            }
            //Location
            HStack{
                if isEditing{
                    Picker("Gym Location", selection: $selectedLocation){
                        ForEach(location, id: \.self){
                            Text($0)
                        }
                    }
                }else{
                    Text("\(selectedLocation)")
                }
            }
            //selectedGym
            HStack{
                if isEditing{
                    Picker("Preferred Gym", selection: $selectedGym){
                        ForEach(gymOption, id: \.self){
                            Text($0)
                        }
                    }
                }else{
                    Text("\(selectedGym)")
                }
            }
            //Description
            HStack{
                Text("Description: \(PT.Description)")
            }
        }
    }
    
    var profileImage: some View{
        HStack{
            Text("Profile Image:")
//            Image("")
        }
    }
    
    var IntroductionImages: some View{
        HStack{
            Text("Additional Images") // TODO: Get this from LandMarks
            VStack{
                Text("Add up to 6 images to show up on trainer profile page together with your profile image")
                //6 Image Thumbnails
                
            }
        }
    }
    
    var IntroductionVideo: some View{
        HStack{
            Text("Add up to 1 short video")
            //Video("")
           
        }
    }
    
    var IDNCertifications: some View{
        VStack{
            HStack{
                Text("ID & Certifications")
                VStack{
                    Text("Upload a photo ID and a selfie")
                    //3-5 Image Thumbnails
                }
            }
        }
    }
    
}

struct Sign_Up_View_Previews: PreviewProvider {
    static var previews: some View {
        Sign_Up_View(PT: PTModel(name: "Hello", gender: "Hello", phone: "Hello", email: "Hello", experienceLevel: "Hello", education: "Hello", Certification: "Hello", gymLocation: .GoodLife, workoutTypes: .Calisthenic, Description: "Hello", Motto: "Hello", PreferredGym: "Hello"))
    }
}
