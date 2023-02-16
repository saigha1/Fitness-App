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
        
        
        var profileSummary: some View{
            VStack{
                HStack{ //No HStack. add padding.
                    Text("Name:")
                    Divider()
                    TextField("Name", text: $PT.name)
    //                }
                }
                HStack{
                    Text("Gender:")
                    Divider()
                    TextField("Male", text: $PT.gender)
                }
                HStack{
                    Text("Phone #:")
                    Divider()
                    TextField("Male", text: $PT.phone)
                }
                HStack{
                    Text("Training Category")
                    Divider()
//                    TextField("Male", text: $PT.typesOfWorkOut)
    //                Picker() TODO: change to Picker or some type
                }
                HStack{
                    Text("Experience Level")
                    Divider()
                    TextField("Experience Level", text: $PT.experienceLevel)  // Needs to be Object
                }
                HStack{
                    Text("Education")
                    Divider()
                    TextField("Education" , text: $PT.education)
                }
                
                HStack{
                    Text("Certification")
                    Divider()
                    TextField("Certficates", text: $PT.Certification)
                }
                
                HStack{
                    Text("Motto")
                    Divider()
                    TextField("Motto", text: $PT.Motto)
    //                If you still look cute at the end of your workout, you didn't work hard enough
                }
                HStack{
                    Text("Location")
                    Divider()
//                    TextField("Mississauga, ON", text: $PT.gymLocation)// TODO: change to Picker or some type
                }
                
                HStack{
                    Text("Preferred Gyms")
                    Divider()
//                    TextField("Preferred Gyms", text: $PT.preferredGym.rawValue) // TODO: change to Picker or some type
                }
                }
        }
        
    var profileImage: some View{
        VStack{
            HStack{
                Text("Description")
                Divider()
                TextField("Description", text: $PT.Description)
            }
            
            HStack{
                Text("Profile Images")
                Image("")
                
            }
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
            VStack{
                HStack{
                    Text("ID & Certifications")
                    VStack{
                        Text("Upload a photo ID and a selfie and up to 3 certifications for verification purpose")
                        //3-5 Image Thumbnails
                    }
                }
                
//                Button(
//                    "Submit",
//                    action: {
//                        EncodingJSON.encode(users : user)
//                    }
//                )
//                .foregroundColor(Color.purple)
//                .cornerRadius(10)
            }
        }
    }


struct Sign_Up_Form_Previews: PreviewProvider {
    static var previews: some View {
        Sign_Up_Form(PT: $PTModel)
    }
}
