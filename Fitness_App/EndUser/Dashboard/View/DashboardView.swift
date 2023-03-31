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
    
    
    var body: some View {
        ScrollView{
            HStack{
                Text("Featured Trainers")
                    .bold()
                    .padding(.leading, 7)
                    .font(.title3)
                Spacer()
            }
            
                
            //Featured Trainers
            ScrollView(.horizontal){
                HStack{
                    ForEach(pTS.filter({ pt in
                        pt.isFeatured
                        
                        
                    }), id: \.id
                            
                    ) { pt in
                        PTCardView(showCategory: true, pt: pt, category: pt.workoutTypes.first!)
                            .padding(7)
                    }
                }
            }
            
            HStack{
                Text("Trainers by Category")
                    .font(.title3)
                    .bold()
                Spacer()
                Button(action: { isFav.toggle()}, label: {Label("Favourite Only", systemImage: "star")
                        .labelStyle(.titleAndIcon)
                    
                })
            }
            .padding(5)
            
            //Dynamic Training Categories
            
//            Text("someText \(pTS.count)" )
            ForEach(typesOfWorkOut.allCases, id: \.rawValue) { workoutCategory in
                if  workoutCategory != .select{
                    HStack{
                        Text(workoutCategory.rawValue)
//                            .bold()
                            .padding(.top, 3)
                            .padding(.leading, 7)
                        Spacer()
                    }
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(pTS.filter({ pt in
                                pt.workoutTypes.contains(workoutCategory)
                                    
                                
                            }), id: \.id
                                    
                            ) { pt in
                                PTCardView(showCategory: false, pt: pt, category: workoutCategory)
                                    .padding(7)
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
