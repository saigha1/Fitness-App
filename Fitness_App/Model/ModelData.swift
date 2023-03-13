//
//  ModelData.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-08.
//

import Foundation
import Combine

class ModelData: ObservableObject{
    
      @Published var users: [NewEndUser] = load("EndUser.json")
//    @Published var PTs: [PTModel] = load("PTs.json")
      @Published var gym: [GymModel] = load("Gyms.json")
      @Published var modelData : ModelData = ModelData()
    
    func encode(users: [EndUserModel]){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let data = try encoder.encode(users)
  
        
        } catch{
            print(error.localizedDescription)
        }
        
//        print(String(data: data, encoding: .utf8)!)
        
    }
}


//Load from  JSON to app
func load<T: Decodable> (_ filename: String) -> T{
    let data : Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Couldn't find \(filename) from main bundle \n \(error)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch{
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


//upload data from app to JSON
//let person = EndUserModel(name: "Josh", age: 30)



//do{
//    data = try Data(contentsOf: file)
//} catch{
//    fatalError("Couldn't find \(filename) from main bundle \n \(error)")
//}
//let jsonEncoder = JSONEncoder()
//jsonEncoder.outputFormatting = .prettyPrinted
//
//do {
//    let encodePerson = try jsonEncoder.encode(person)
//    let endcodeStringPerson = String(data: encodePerson, encoding: .utf8)!
//    print(endcodeStringPerson)
//} catch {
//    print(error.localizedDescription)
//}
//

