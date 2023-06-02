//
//  NavigationViewModel.swift
//  Fitness_App
//
//  Created by MAC on 2023-06-02.
//

import Foundation

class NavigationViewModel : ObservableObject{
    @Published var nextScreen: NextTab = .none
    
    func selectNone(){
        nextScreen = .none
    }
   
}
enum NextTab: String {
    case calendar = "Calendar"
    case dashboard = "Dashboard"
    case explore = "Explore"
    case chat = "Chat"
    case none = ""
}
