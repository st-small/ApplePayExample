//
//  ViewController.swift
//  ApplePayExample
//
//  Created by Станислав Шияновский on 10/1/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import PassKit
import UIKit

public class ViewController: UIViewController {
    
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.ua.kr.ssh.ApplePayExample"
        request.supportedNetworks = [.visa, .masterCard]
        request.supportedCountries = ["US"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iPhone Xs 64 Gb", amount: 34999.99)]
        return request
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func purchase(_ sender: Any?) {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
}

extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
