//
//  PurchasePlansView.swift
//  Fitness_App
//
//  Created by MAC on 2023-05-16.
//

import SwiftUI
import PassKit


struct PurchasePlansView: View {
    var pt: PTModel
    @StateObject var vm = PurchasePlanViewModel()
    @EnvironmentObject var paymentVM: ApplePayViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    VStack {
                        content
                        
                    }
                }
            }
            .padding()
            .navigationTitle("Purchase Plans")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var content: some View{
        return Group{
            Text("Select a plan from the following options")
            Group{
                HStack{
                    Button {
                        vm.selectedPurchasePlan = .Workout
                    } label: {
                        HStack{
                            Image(systemName: "figure.run")
                                .resizable()
                                .frame(width: 23, height: 28)
                            Text("Workout Plan")
                                .bold()
                        }
                        .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width/2.5, height: 50)
                    .background(Color.assetColor.blue.cornerRadius(5))
                    
                    
                    Button {
                        vm.selectedPurchasePlan = .Diet
                    } label: {
                        HStack{
                            Image(systemName: "fork.knife")
                                .resizable()
                                .frame(width: 23, height: 25)
                            Text("Diet Plan")
                                .bold()
                        }
                        .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width/2.5, height: 50)
                    .background(Color.assetColor.darkPurple.cornerRadius(5))
                }
            }
            
            Button {
                vm.selectedPurchasePlan = .Bundle
            } label: {
                VStack{
                    HStack{
                        Image(systemName: "figure.run")
                        Image(systemName: "plus")
                        Image(systemName: "fork.knife")
                        Text("Workout & Diet Plan Bundle")
                            .bold()
                        
                    }
                    .foregroundColor(.white)
                    Text("12% Discount")
                        .foregroundColor(.assetColor.red)
                        .font(.system(size: 10))
                        .bold()
                }
            }
            .frame(width: UIScreen.main.bounds.width/1.21, height: 50)
            .background(Color.assetColor.pink.opacity(0.5).cornerRadius(5))
            
            
            Text("Or, contact the trainer to learn more about plans first")
                .foregroundColor(.secondary)
                .font(.system(size: 12))
            
            GroupBox{
                HStack{
                    pt.ptProfileImage.asProfileImage(100)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text(pt.name)
                                .bold()
                            Text("Trainer")
                                .foregroundColor(.white)
                                .font(.footnote)
                                .bold()
                                .padding(2)
                                .background(Color.assetColor.blue.cornerRadius(5))
                                .padding(.horizontal, 10)
                            Spacer()
                        }
                        ForEach(pt.workoutTypes, id: \.rawValue) {
                            if $0 != .select {
                                Text($0.rawValue)
                            }
                        }
                        
                    }
                    Image(systemName: "ellipses.bubble")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
                summary
        }
    }
    
    var summary : some View{
        Group{
            Text("Summary")
                .bold()
            GroupBox {
                VStack{
                HStack{
                    VStack{
                        Text("Trainer:")
                        Text("Plan:")
                        Text("SubTotal:")
                        Text("Estimated Tax:")
                        Text("SubTotal:")
                    }
                    Spacer()
                    VStack{
                        Text(pt.name)
                        Text(vm.selectedPurchasePlan.rawValue)
                        Text(vm.subTotal.formatted(.currency(code: "CAD")))
                        Text(vm.estimatedTax.formatted(.currency(code: "CAD")))
                        Text(vm.Total.formatted(.currency(code: "CAD")))
                    }
                }
                
                HStack{
                    ApplyPayButton(amount: vm.subTotal, tax: vm.estimatedTax, total: vm.Total)
                        .environmentObject(paymentVM)
                }
                }
            }
        }
    }
    
}

struct PurchasePlansView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        PurchasePlansView(pt: emptyPTModel)
            .environmentObject(ApplePayViewModel())
    }
}

var emptyPTModel = PTModel(id: "", ptProfileImage: "https://images.unsplash.com/photo-1581009137042-c552e485697a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80", name: "Bob", email: "", phone: "", gender: .select, isFeatured: false, isFavorite: false, isApproved: false, education: .select, certification: [.select, .select], selectedExperience: .select, cityLocation: .select, gymPreference: [.select, .select, .select], workoutTypes: [.machine, .calisthenic, .americanBoxing], motto: "", description: "", imageString: ["","",""], videoUrl: [""])
