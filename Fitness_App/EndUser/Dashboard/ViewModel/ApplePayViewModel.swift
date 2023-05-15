//
//  ApplePayViewModel.swift
//  Fitness_App
//
//  Created by Xavier on 5/15/23.
//

import Foundation
import PassKit
class ApplePayViewModel: ObservableObject {
    @Published var paymentStatus: PKPaymentAuthorizationStatus?

    @Published var nextScreen: NextScreenAfterPayment = .none
    func clearPaymentStates() {
        paymentStatus = nil
        nextScreen = .none
    }
}
enum NextScreenAfterPayment: String {
    case calendar = "Calendar"
    case dashboard = "Dashboard"
    case profile = "Profile"
    case none = ""
}
