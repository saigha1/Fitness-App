//
//  ApplePayButtonView.swift
//  Fitness_App
//
//  Created by MAC on 2023-04-26.
//
//
//  TestView.swift
//  Fitness_App
//
//  Created by Xavier on 4/26/23.
//

import SwiftUI
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

struct ApplyPayButton: View {
    var amount : Double = 0
    var tax : Double = 0
    var total : Double = 0
    let paymentHandler = PaymentHandler() //As defined by Taif
    
    //Added this for payment values
   
    var body: some View {
        Button(action: {
            // Using the code from Tarif!
            self.paymentHandler.startPayment(amount: amount, tax: tax, total: total ){ success in
                if success {
                    print("Success")
                } else {
                    print("Failed")
                }
            }
        }, label: { EmptyView() } )
            .buttonStyle(PaymentButtonStyle())
    }
}

struct PaymentButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return PaymentButtonHelper()
    }
}
    
struct PaymentButtonHelper: View {
    var body: some View {
        PaymentButtonRepresentable()
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
    }
}

extension PaymentButtonHelper {
    struct PaymentButtonRepresentable: UIViewRepresentable {
        
        var button: PKPaymentButton {
            let button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black) /*customize here*/
            button.cornerRadius = 4.0 /* also customize here */
            return button
        }
        
        func makeUIView(context: Context) -> PKPaymentButton {
            return button
        }
        func updateUIView(_ uiView: PKPaymentButton, context: Context) {
            
        }
    }
}


class PaymentHandler: NSObject {
    static let supportedNetworks: [PKPaymentNetwork] = [
        .amex,
        .masterCard,
        .visa
    ]
    
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    func startPayment(amount: Double, tax: Double, total: Double , completion: @escaping PaymentCompletionHandler) {
        
        let amount = PKPaymentSummaryItem(label: "Amount", amount: NSDecimalNumber(string: "\(amount)"), type: .final)
        let tax = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "\(tax)"), type: .final)
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total)"), type: .final)
        
        paymentSummaryItems = [amount, tax, total];
        completionHandler = completion
        
        // Create our payment request
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.xavier.testapplepay"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "CA"
        paymentRequest.currencyCode = "CAD"
        paymentRequest.requiredShippingContactFields = [.phoneNumber, .emailAddress]
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        
        // Display our payment request
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                NSLog("Presented payment controller")
            } else {
                NSLog("Failed to present payment controller")
                self.completionHandler!(false)
            }
        })
    }
}

/*
 PKPaymentAuthorizationControllerDelegate conformance.
 */
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        // Perform some very basic validation on the provided contact information
        if payment.shippingContact?.emailAddress == nil || payment.shippingContact?.phoneNumber == nil {
            paymentStatus = .failure
        } else {
            // Here you would send the payment token to your server or payment provider to process
            // Once processed, return an appropriate status in the completion handler (success, failure, etc)
            paymentStatus = .success
        }
        
        completion(paymentStatus)
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    self.completionHandler!(true)
                } else {
                    self.completionHandler!(false)
                }
            }
        }
    }
    
}

struct ApplePayButton_Previews: PreviewProvider {
    static var previews: some View {
    ApplyPayButton()
    }
}
