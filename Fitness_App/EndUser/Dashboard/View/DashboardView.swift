//
//  DashboardView.swift
//  Fitness_App
//
//  Created by MAC on 2023-03-30.
//

import SwiftUI

struct DashboardView: View {
    @State var favOnly : Bool = false
    @State var pTS : [PTModel] = []
    @EnvironmentObject var authVM: AuthViewModel
    @State var sortState : sortingType = .rating
    @EnvironmentObject var paymentVM: ApplePayViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Dashboard")
                .toolbar {
                    ToolbarItem {
                        UserProfileIconView()
                            .environmentObject(authVM)
                    }
                }
        }
    }
    
    var content: some View {
        ScrollView{
            HStack{
                Text("Featured Trainers")
                    .fontWeight(.heavy)
                    .padding(.top, 5)
                    .padding(.leading, 10)
                    .font(.headline)
                Spacer()
            }
            
            
            //Featured Trainers
            ScrollView(.horizontal){
                HStack{
                    ForEach(pTS.filter({ pt in
                        pt.isFeatured
                        
                        
                    }), id: \.id
                            
                    ) { pt in
                        NavigationLink {
                            PTPageProfileView(pt: pt)
                                .environmentObject(authVM)
                                .environmentObject(paymentVM)
                        } label: {
                            PTCardView(showCategory: true, pt: pt, category: pt.workoutTypes.first!)
                                .foregroundColor(.primary)
                                .padding(.leading, -1)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            Group{
                HStack(alignment: .center){
                    Text("Trainers by Category")
                        .fontWeight(.heavy)
                        .font(.headline)
                    Spacer()
                    //Favourite button
                    Button(action: { favOnly.toggle()}, label: {
                        VStack {
                            Image(systemName: favOnly ? "star.fill" : "star")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 12)
                            Text("Favourites")
                                .font(.footnote)
                        }
                        .foregroundColor(favOnly ? .orange : .accentColor)
                        .frame(height: 50)
                    })
                    
                    //Sorting option button
                    Menu {
                        ForEach(sortingType.allCases, id : \.rawValue){option in
                            Button {
                                switch option{
                                case .price : sortState = .price
                                case .experience : sortState = .experience
                                case .isFeatured: sortState = .isFeatured
                                default : sortState = .rating
                                }
                            } label: {
                                HStack{
                                    Text("Sort by \(option.rawValue)")
                                    Spacer()
                                    if option == sortState {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                        
                        
                    } label: {
                        VStack {
                            Image(systemName: "line.3.horizontal.decrease")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 12)
                            Text("Sort")
                                .font(.footnote)
                        }
                        .foregroundColor(.accentColor)
                    }
                    
                }
                
                .padding(.top, 5)
                .padding(.horizontal, 10)
            }
            
            //Dynamic Training Categories
            ForEach(typesOfWorkOut.allCases, id: \.rawValue) { workoutCategory in
                if  workoutCategory != .select{
                    HStack{
                        Text(workoutCategory.rawValue)
                            .font(.subheadline)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    ScrollView(.horizontal){
                        HStack{
                            //TODO: - Implement a second .sorted to sort PTs by internal score (ranking)
                            ForEach(pTS.filter({ pt in
                                favOnly ? pt.isFavorite : true
                                &&
                                pt.workoutTypes.contains(workoutCategory)
                                
                                
                            }).sorted{pt1, pt2 in
                                switch sortState{
                                case .price : return true
                                case .experience : return {
                                    let dictionary: [PTexperienceLevel : Int] = [.select : -1, .One : 1, .Two : 2, .Three : 3, .Other : 0 ]
                                    let pt1Level = dictionary[pt1.selectedExperience]!
                                    let pt2Level = dictionary[pt2.selectedExperience]!
                                    return pt1Level > pt2Level
                                }()
                                case .isFeatured: return pt1.isFeatured
                                default : return true
                                }
                                
                            }, id: \.id
                                    
                            ) { pt in
                                NavigationLink {
                                    PTPageProfileView(pt: pt)
                                        .environmentObject(paymentVM)
                                } label: {
                                    PTCardView(showCategory: false, pt: pt, category: workoutCategory)
                                        .foregroundColor(.primary)
                                        .padding(.leading, -1)
                                    
                                    
                                }
                                
                            }
                            .padding(0)
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        
                    }
                    
                }
            }
        }
        .onAppear{
            guard let pTS : [PTModel] = load(filename: "PTs.json", location: .document) else { return }
            
            self.pTS = pTS.filter({ PT in
                guard let userGyms = authVM.currentEndUser?.preferredGym else { return true }
                let PTGyms = PT.gymPreference
                var hasCommon = false
                
                for userGym in userGyms {
                    for PTGym in PTGyms {
                        if (userGym.rawValue == PTGym.rawValue) && PTGym != .select {
                            hasCommon = true
                            break
                        }
                    }
                    if hasCommon{
                        break
                    }
                }
                return hasCommon
            })
        }
    }
    
    enum sortingType: String, CaseIterable{
        case price = "Price"
        case experience = "Experience Level"
        case rating = "Rating"
        case isFeatured = "Featured"
    }
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(AuthViewModel())
            .environmentObject(ApplePayViewModel())
    }
}
