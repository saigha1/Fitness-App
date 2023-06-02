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

    func clearPaymentStates() {
        paymentStatus = nil
    }
}
