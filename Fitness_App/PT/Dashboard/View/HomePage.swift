//
//  HomePage.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-13.
//

import SwiftUI

struct HomePage: View {
    @State var pTApproved : Bool = false
    @State var pending : Bool = false
    @State var rejected : Bool = false
    @State var submitted : Bool = false
    
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
    //PT
    private var homePageForPT: some View {
        Group {
            if let user = authVM.currentPTUser {
                if (pTApproved){
                    TabView{
                        Dashboard()
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
                } else if (pending) {
                    Text("Your profile approval in process. Please await the decision.")
                } else if (rejected) {
                    Text("Your profile is rejected. Please call support at 1213-456-7890")
                } else if !submitted{
                    //Sign_Up_View()
                    Text("Please complete your profile.")
                }
            }
        }
    }
    
    //END-USER
    private var homePageForEndUser: some View {
        Group {
            
            if isEndUserApproved {
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
                    UserSignUpFormView()
                }

            }
        }
        .onAppear {
            endUserApprovalCheck()
        }
    }
    private func endUserApprovalCheck() {
        isEndUserApproved = authVM.endUserApprovalCheck()
    }
    private var endUserTabView: some View {
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
