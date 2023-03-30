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
            Text("Featured Trainers").bold()
            ScrollView(.horizontal){
                //Featured Trainers
            }
            HStack{
                Text("Trainers by Category")
                Spacer()
                Button(action: { isFav.toggle()}, label: {Label("Favourite Only", systemImage: "star")
                        .labelStyle(.titleAndIcon)
                    
                })
            }
            .padding(5)
            
            //Dynamic Training Categories
//            ForEach(typesOfWorkOut.allCases) { workoutType in
//                ScrollView(.horizontal){
//                    //Training Category x
//                    HStack{
//                        ForEach(pTS.filter{ type1 in
//                            type1.workoutTypes.contains(where: { type2 in
//                                type1.rawValue == type2.rawValue
//                            })
//                        }) { <#Identifiable#> in
//
//                        }
//                    }
//
//
//
//                }
//            }
            Text("osometxt \(pTS.count)" )
            ScrollView(.horizontal){
                HStack{
                    ForEach(pTS.filter({ pt in
                        pt.workoutTypes.contains(.calisthenic)
                            
                        
                    }), id: \.id
                            
                    ) { pt in
                        PTCardView(pt: pt)
                            .padding(7)
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
