//
//  Encoding.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-14.
//

import SwiftUI

class encodingJSON: ObservableObject{

     @StateObject var modelData : ModelData = ModelData()
    
    
    func encode(users: [EndUserModel]){
        print("Encoding JSON")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let data = try encoder.encode(users)
//   TODO: UNcomment         modelData.users += String(data: data, encoding: .utf8)!
//                .append(contentsOf: data)
        } catch{
            print(error.localizedDescription)
        }
        
//        print(String(data: data, encoding: .utf8)!)
        
    }
    
}

