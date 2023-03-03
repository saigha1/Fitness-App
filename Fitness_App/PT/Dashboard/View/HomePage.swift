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
    
    @State var isEndUserApproved: Bool = false
    
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
            if let user = authVM.currentEndUser {
                if (pTApproved && !pending && !signUp){
                    TabView{
                        Dashboard(user: user)
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
    }
    private var homePageForEndUser: some View {
        Group {
            
            if isEndUserApproved {
                //TODO: 1 - populate values from JSON
                endUserTabView
            } else {
                Text("").fullScreenCover(isPresented: .init(
                    get: {
                        !self.isEndUserApproved
                }, set: {
                    self.isEndUserApproved = !$0
                })) {
                    endUserApprovalCheck()
                } content: {
                    //TODO: 2 - populate states from Firebase
                    UserSignUpFormView()
                }

            }
        }
        .onAppear {
            endUserApprovalCheck()
        }
    }
    private func endUserApprovalCheck() {
        guard let user = authVM.currentUser, authVM.isEnderUser else { return }
        #if DEBUG
        print("--------Firebase User Info----------")
        print("Object:", user)
        print("Firebase UID", user.uid)
        print("Email", user.email ?? "")
        print("Phone", user.phoneNumber ?? "")
        #endif
        let allUsersApproved: [NewEndUser] = load(filename: "EndUser.json", location: .document) ?? []
        if allUsersApproved.count <= 0 {
            self.isEndUserApproved = false
        } else {
            if let currentEndUser = allUsersApproved.first(where: { $0.id == user.uid }) {
                self.isEndUserApproved = true
                self.authVM.currentEndUser = currentEndUser
            }
        }
    }
    private var endUserTabView: some View {
        Group {
            if authVM.currentEndUser != nil {
                TabView {
                    EndUserDashBoardView(user: authVM.currentEndUser)
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
    }
}
