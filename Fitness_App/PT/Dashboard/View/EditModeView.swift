//
//  EditModeView.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-15.
//

import SwiftUI

struct EditModeView: View {
    @Environment(\.editMode) var editMode
    
    var body: some View {
        if editMode?.wrappedValue == .active{
            Button ("Cancel", role: .cancel){
                
                //write code here
            }
            
        }
        
        Spacer()
        EditButton()
        
        if editMode?.wrappedValue == .inactive{
            //inactive
        } else{
            
        }
        
        
    }
}

struct EditModeView_Previews: PreviewProvider {
    static var previews: some View {
        EditModeView()
    }
}
