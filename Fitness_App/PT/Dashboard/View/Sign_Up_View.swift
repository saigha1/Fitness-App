//
//  Sign-Up View.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-07.
//

import SwiftUI

struct Sign_Up_View: View {
  
    @StateObject var modelData : ModelData = ModelData()
    
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
                Text("Name: \(PT.name)")

            }
            HStack{
                Text("Gender: \(PT.gender)")
            
            }
            HStack{
                Text("Training Category: \(PT.workoutTypes.rawValue)")
//                Picker() //Add up to 3
            }
            HStack{
                Text("Experience Level: \(PT.experienceLevel)")
                
            }
            HStack{
                Text("Education: \(PT.education)")
              
            }
            
            HStack{
                Text("Certification: \(PT.Certification)")
            }
            
            HStack{
                Text("Motto: \(PT.Motto)")
                
            }
            HStack{
                Text("Location: \(PT.gymLocation.rawValue)")
            }
            
            HStack{
                Text("Preferred Gyms: \(PT.PreferredGym)")
            }
            
            HStack{
                Text("Description: \(PT.Description)")
            }
        }
    }
    
    var profileImage: some View{
        HStack{
            Text("Profile Images")
//            Image("")
        }
    }
    
    var IntroductionImages: some View{
        HStack{
            Text("Introduction Images") // TODO: Get this from LandMarks
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
                    Text("Upload a photo ID and a selfie and up to 3 certifications for verification purpose")
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
