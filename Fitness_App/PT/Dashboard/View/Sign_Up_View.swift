//
//  Sign-Up View.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-07.
//

import SwiftUI

struct Sign_Up_View: View {

    @StateObject var modelData : ModelData = ModelData()
    
    var body: some View {
        VStack{
            Text("Sign up as a Trainer")
                .underline()
            profileSummary
            profileImage
            IntroductionImages
            IntroductionVideo
            IDNCertifications
            

        }
    }
    //true= profile.user.approved
//                if (true){
//                    //                Text(\(profile.user.name)) // Needs to be Object
//                } else{
//                    TextField(<#T##title: StringProtocol##StringProtocol#>, text: <#T##Binding<String>#>)
//                }
    
    var profileSummary: some View{
        VStack{
            HStack{
                Text("Name:")
                Text("\(modelData.gym[0].id)")
                
            }
            HStack{
                Text("Gender")
//                TextField("Male") // Needs to be Object
            }
            HStack{
                Text("Training Category")
//                Picker() //Add up to 3
            }
            HStack{
                Text("Experience Level")
//                TextField("10 years")  // Needs to be Object
            }
            HStack{
                Text("Education")
//                TextField("B.S. in Sports Management. M.S. in Health, Exercise, & Sports Science")
            }
            
            HStack{
                Text("Certification")
//                TextField("Certficate in IV Fitness")
            }
            
            HStack{
                Text("Motto")
//                TextField("If you still look cute at the end of your workout, you didn't work hard enough")
            }
            HStack{
                Text("Location")
//                TextField("Mississauga, ON")
            }
            
            HStack{
                Text("Preferred Gyms")
//                TextField("GoodLife, LifeTime, Planet Fitness")
            }
            
            HStack{
                Text("Description")
//                TextField("Weight Lifting ptrofessional with 10+ years of experience training individuals and athletes. Competed provincially and won silver medal.")
            }
            
            //          Button(action: submitForConfirmation(), label: "Submit")
            //        }
            
        }
    }
    
    var profileImage: some View{
        HStack{
            Text("Profile Images")
            Image("")
           
        }
    }
    
    var IntroductionImages: some View{
        HStack{
            Text("Introduction Images")
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
        HStack{
            Text("ID & Certifications")
            VStack{
                Text("Upload a photo ID and a selfie and up to 3 certifications for verification purpose")
                //3-5 Image Thumbnails
            }
           
        }
    }
    
}

struct Sign_Up_View_Previews: PreviewProvider {
    static var previews: some View {
        Sign_Up_View()
    }
}
