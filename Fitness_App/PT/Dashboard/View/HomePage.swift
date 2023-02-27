//
//  HomePage.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-13.
//

import SwiftUI

struct HomePage: View {
    @State var pTApproved : Bool = true
    @State var pending : Bool = false
    @State var signUp : Bool = false
    
    @EnvironmentObject var authVM : AuthViewModel
    
    
    var body: some View {
        
        if authVM.isEnderUser {
            homePageForEndUser
        } else {
            homePageForPT
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(AuthViewModel())
    }
}

extension HomePage {
    private var homePageForPT: some View {
        Group {
            if (pTApproved && !pending && !signUp){
                TabView{
                    Dashboard(user: authVM.currentEndUser)
                        .tabItem{
                            Label("Dashboard", systemImage: "house")
                        }
                        .environmentObject(authVM)
                    
                    ChatView()
                        .tabItem{
                            Label("Chat", systemImage: "message")
                        }
                    
                    CalendarView()
                        .tabItem{
                            Label("Calendar", systemImage: "calendar.badge.clock")
                        }
                }
            } else if (!pTApproved && pending && !signUp) {
                pTPending()
            } else if (!pTApproved && !pending && signUp) {
                //Sign_Up_View()
                Text("Sign up view goes here")
            } else{
                //Sign_Up_View()
                Text("Sign up view goes here")
            }
        }
    }
    private var homePageForEndUser: some View {
        Text("EndUser")
    }
}
