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
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = PurchasePlanViewModel()
    @EnvironmentObject var paymentVM: ApplePayViewModel
    @State var showSuccessAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    VStack {
                        content
                    }
                    if showSuccessAlert {
                        PaymentConfirmationAlert(buttons: {
                            paymentConfirmationButton
                        }, height: UIScreen.main.bounds.height * 0.28, spacerHeight: UIScreen.main.bounds.height * 0.1 * 0.05)
                    }
                }
            }
            .padding()
            .navigationTitle("Purchase Plans")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if let firstType = pt.workoutTypes.first {
                vm.selectedTypeOfWorkOut = firstType
            }
        }
        .onDisappear {
            paymentVM.clearPaymentStates()
        }
    }
    var paymentConfirmationButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Continue Browsing")
                .foregroundColor(.assetColor.red)
                .bold()
                .frame(width: 200, height: 40)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.assetColor.red, lineWidth: 2)
                )
        }

    }
    var content: some View{
        return Group{
            VStack(alignment: .leading) {
                Text("Select a workout category")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .bold()
                Picker(selection: $vm.selectedTypeOfWorkOut) {
                    ForEach(pt.workoutTypes, id: \.self) { type in
                        let matching = matchingTypesOfWorkOut.contains(type)
                        Text((matching ? "🟠  " : "") + type.rawValue)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(.segmented)
                Text("Select a plan option")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .bold()
            }
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
            
            VStack(alignment: .leading) {
                Text("Or, contact the trainer to learn more about plans first")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12))
            }
            
            GroupBox{
                HStack{
                    pt.ptProfileImage.asProfileImage(100, padding: 0)
                    
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
                        Text(vm.selectedTypeOfWorkOut.rawValue)
                        
                    }
                    
                    chatButton
                }
            }
            
            Divider()
            summary
        }
    }
    var chatButton: some View {
        Button {
            paymentVM.nextScreen = .chat
            dismiss()
        } label: {
            Group {
                if #available(iOS 16.0, *) {
                    Image(systemName: "ellipsis.message")
                        .resizable()
                        .foregroundColor(.secondary)
                } else {
                    Image(systemName: "ellipses.bubble")
                        .resizable()
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 35, height: 35)
            
        }

    }
    var summary : some View{
        Group{
            VStack(alignment: .leading) {
                Text("Summary")
                    .bold()
                GroupBox {
                    VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Trainer:")
                            Text("Plan:")
                            Text("SubTotal:")
                            Text("Estimated Tax:")
                            Text("SubTotal:")
                        }
                        Spacer()
                        VStack(alignment: .leading){
                            Text(pt.name)
                            Text(vm.selectedPurchasePlan.rawValue)
                            Text(vm.subTotal.formatted(.currency(code: "CAD")))
                            Text(vm.estimatedTax.formatted(.currency(code: "CAD")))
                            Text(vm.Total.formatted(.currency(code: "CAD")))
                        }
                    }
                    
                        switch paymentVM.paymentStatus {
                        case .success: VStack {}
                                .onAppear {
                                    guard let user = authVM.currentEndUser else { return }
                                    vm.saveTransaction(pt: pt, endUser: user)
                                    showSuccessAlert.toggle()
                        }
                        default: paymentButton
                        }
                    }
                }
            }
            
        }
    }
    
    var paymentButton: some View {
        HStack{
            ApplyPayButton(amount: vm.subTotal, tax: vm.estimatedTax, total: vm.Total)
                .environmentObject(paymentVM)
        }
    }
    private var matchingTypesOfWorkOut: [typesOfWorkOut] {
        let ptTypes = pt.workoutTypes
        guard let userTypes = authVM.currentEndUser?.typesOfWorkOut else { return [] }
        let result = ptTypes.filter { ptType in
            userTypes.contains { userType in
                userType.rawValue == ptType.rawValue
            }
        }
        return result
    }
}

struct PurchasePlansView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        PurchasePlansView(pt: emptyPTModel)
            .environmentObject(ApplePayViewModel())
            .environmentObject(AuthViewModel())
    }
}

var emptyPTModel = PTModel(id: "", ptProfileImage: "https://images.unsplash.com/photo-1581009137042-c552e485697a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80", name: "Bob", email: "", phone: "", gender: .select, isFeatured: false, isFavorite: false, isApproved: false, education: .select, certification: [.select, .select], selectedExperience: .select, cityLocation: .select, gymPreference: [.select, .select, .select], workoutTypes: [.machine, .calisthenic, .americanBoxing], motto: "", description: "", imageString: ["","",""], videoUrl: [""])
