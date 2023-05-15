//
//  HomePage.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-13.
//

import SwiftUI

struct HomePage: View {
//    @State var pTApproved : Bool = false
    @State var pending : Bool = false
    @State var rejected : Bool = false
    @State var submitted : Bool = false
    
    @State var isEndUserApproved: Bool = false
    @EnvironmentObject var ptVM : PTValidationModel
    
    @EnvironmentObject var authVM : AuthViewModel
    @State var endUserTabSelection = "Dashboard"
    @StateObject var paymentVM = ApplePayViewModel()
    var body: some View {
        if !authVM.isEndUser {
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
                vm.isEndUser.toggle()
            }
        HomePage()
        //End User HomePage
            .environmentObject(vm)
    }
}

extension HomePage {
    //PT
    private func ptApprovalCheck(){
        pending = authVM.endUserApprovalCheck()
    }
     var homePageForPT: some View {
        Group {
            if let user = authVM.currentPTUser {
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
                } else {
                    Sign_Up_View(user: emptyPTModel)
                        .environmentObject(authVM)
                   
                }
            
        }
        .onAppear{
            ptApprovalCheck()
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
                        .environmentObject(authVM)
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
        TabView(selection: $endUserTabSelection) {
            DashboardView()
                .environmentObject(authVM)
                .environmentObject(paymentVM)
                .tabItem{
                    Label("Dashboard", systemImage: "house")
                }
                .tag("Dashboard")
            EndUserChatView()
                .tabItem{
                    Label("Chat", systemImage: "message")
                }
                .tag("Chat")
            EndUserExploreView()
                .tabItem{
                    Label("Explore", systemImage: "safari.fill")
                }
                .tag("Explore")
            EndUserCalendarView()
                .tabItem{
                    Label("Calendar", systemImage: "calendar.badge.clock")
                }
                .tag("Calendar")
        }
        .onChange(of: paymentVM.nextScreen) { newValue in
            print("nextScreen should change")
            switch newValue {
            case .calendar: endUserTabSelection = NextScreenAfterPayment.calendar.rawValue
            case .dashboard: endUserTabSelection = NextScreenAfterPayment.dashboard.rawValue
            default: return
            }
        }
    }
}
