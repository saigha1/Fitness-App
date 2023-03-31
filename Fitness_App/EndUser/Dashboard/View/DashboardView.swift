//
//  DashboardView.swift
//  Fitness_App
//
//  Created by MAC on 2023-03-30.
//

import SwiftUI

struct DashboardView: View {
    @State var isFav : Bool = false
    @State var pTS : [PTModel] = []
    @EnvironmentObject var authVM: AuthViewModel
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
                        } label: {
                            PTCardView(showCategory: true, pt: pt, category: pt.workoutTypes.first!)
                                .foregroundColor(.primary)
                                .padding(.leading, 5)
                                .padding(.vertical, 5)
                                .padding(.trailing, 2)
                        }
                    }
                }
            }
            
            HStack(alignment: .center){
                Text("Trainers by Category")
                    .fontWeight(.heavy)
                    .font(.headline)
                Spacer()
                //Favourite button
                Button(action: { isFav.toggle()}, label: {
                    VStack {
                        Image(systemName: "star")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 12)
                        Text("Favourites")
                            .font(.footnote)
                    }
                    .foregroundColor(.accentColor)
                    .frame(height: 50)
                })
                //Sorting option button
                Menu {
                    Button {
                        print("sort by price tapped")
                    } label: {
                        Text("Sort by price")
                    }
                    Button {
                        print("sort by experience level tapped")
                    } label: {
                        Text("Sort by experience level")
                    }
                    Button {
                        print("sort by rating tapped")
                    } label: {
                        Text("Sort by rating")
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
                            ForEach(pTS.filter({ pt in
                                pt.workoutTypes.contains(workoutCategory)
                                
                                
                            }), id: \.id
                                    
                            ) { pt in
                                NavigationLink {
                                    PTPageProfileView(pt: pt)
                                } label: {
                                    PTCardView(showCategory: false, pt: pt, category: workoutCategory)
                                        .foregroundColor(.primary)
                                        .padding(.leading, 5)
                                        .padding(.vertical, 5)
                                        .padding(.trailing, 2)
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            guard let pTS : [PTModel] = load(filename: "PTs.json", location: .document) else { return }
            self.pTS = pTS
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
