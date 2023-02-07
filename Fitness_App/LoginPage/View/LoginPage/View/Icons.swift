//
//  Icons.swift
//  Fitness_App
//
//  Created by Xavier on 2/6/23.
//

import SwiftUI


let tabIcon_Dashboard = Image(systemName: "house.fill")
let tabIcon_Chat = Image(systemName: "ellipsis.bubble.fill")
let tabIcon_Explore = Image(systemName: "safari.fill")
let tabIcon_Calendar = Image(systemName: "calendar")

let userProfileIcon_Person = Image(systemName: "person.fill")
let userProfileIcon_Preference = Image(systemName: "gearshape")
let userProfileIcon_Health = Image(systemName: "heart.fill")
let userProfileIcon_Journey = Image(systemName: "chart.line.uptrend.xyaxis")

let sharedIcon_CancelOrDislike: some View = Image(systemName: "xmark").foregroundColor(Color.assetColor.pink)
let sharedIcon_Chat = Image(systemName: "ellipsis.bubble")

let exploreIcon_Like = Image(systemName: "suit.heart")

let chatIcon_Call = Image(systemName: "phone.and.waveform.fill")
let chatIcon_Send = Image(systemName: "paperplane")

let homeIcon_isFav: some View = Image(systemName: "star.fill").foregroundColor(.yellow)
let homeIcon_notFav: some View = Image(systemName: "star").foregroundColor(.gray)


//MARK: Added new icons for preview if needed
extension Icons {
    private var tabIcons: some View {
        VStack {
            Text("Tab Icons")
            HStack {
                tabIcon_Dashboard
                tabIcon_Chat
                tabIcon_Explore
                tabIcon_Calendar
            }
        }
    }
    private var userProfileIcons: some View {
        VStack {
            Text("User Profile Icons")
            HStack {
                userProfileIcon_Person
                userProfileIcon_Preference
                userProfileIcon_Health
                userProfileIcon_Journey
            }
        }
    }
    private var sharedIcons: some View {
        VStack {
            Text("Shared Icons")
            HStack {
                sharedIcon_CancelOrDislike
                sharedIcon_Chat
            }
        }
    }
    private var exploreIcons: some View {
        VStack {
            Text("Explore Icons")
            HStack {
                exploreIcon_Like
            }
        }
    }
    private var homeIcons: some View {
        VStack {
            Text("Home Icons")
            HStack {
                homeIcon_isFav
                homeIcon_notFav
            }
        }
    }
}

struct Icons: View {
    var body: some View {
        VStack {
            tabIcons
            userProfileIcons
            sharedIcons
            exploreIcons
            homeIcons
        }
    }
}

struct Icons_Previews: PreviewProvider {
    static var previews: some View {
        Icons()
    }
}
