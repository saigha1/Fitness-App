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
        
        if !authVM.isEnderUser {
            homePageForPT
        } else {
            homePageForEndUser
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static let vm = AuthViewModel()
    static var previews: some View {
        //PT HomePage
        HomePage()
            .environmentObject(vm)
            .onAppear {
                vm.isEnderUser.toggle()
            }
        HomePage()
        //End User HomePage
            .environmentObject(vm)
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
        TabView {
            EndUserDashBoardView()
                .tabItem{
                    Label("Dashboard", systemImage: "house")
                }
                .environmentObject(authVM)
            EndUserChatView()
                .tabItem{
                    Label("Chat", systemImage: "message")
                }
            EndUserExploreView()
                .tabItem{
                    Label("Explore", systemImage: "safari.fill")
                }
            EndUserCalendarView()
                .tabItem{
                    Label("Calendar", systemImage: "calendar.badge.clock")
                }
        }
    }
}
