//
//  PayPopOverViewController.swift
//  
//
//  Created by Kevin VACQUIER on 10/01/2016.
//
//

import UIKit
import Stripe
import Alamofire
import Parse

class PayPopOverViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    var payButton: UIButton!
    var paymentTextField: STPPaymentCardTextField!
    
    override func viewDidLoad() {
        // add text field for fill card information
        super.viewDidLoad()
        let frame1 = CGRect(x: 20, y: 150, width: self.view.frame.size.width - 40, height: 40)
        paymentTextField = STPPaymentCardTextField(frame: frame1)
        paymentTextField.center = view.center
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        // add button for pay
        let frame2 = CGRect(x: 100, y: 150, width: 200, height: 40)
        payButton = UIButton(frame: frame2)
        payButton.setTitle("Pay 20$", forState:.Normal)
        payButton.backgroundColor = UIColor.redColor()
        payButton.addTarget(self, action: "createToken", forControlEvents: .TouchUpInside)
        view.addSubview(payButton)
    }
    
    func createToken() {
        let card = STPCard()
        card.expMonth = paymentTextField.expirationMonth
        card.expYear = paymentTextField.expirationYear
        card.number = paymentTextField.cardNumber
        card.cvc = paymentTextField.cvc
        // get stripe token for curent card
        Stripe.createTokenWithCard(card) { token, error in
            if let token = token {
                print(token)
                self.postStripeToken(token)
            } else {
                print(error)
            }
        }
    }
    // charge money from Cloud Module Parse
    func postStripeToken(token: STPToken) {
        let params: [String: NSObject] = ["stripeToken": token.tokenId,
            "amount": 10 ]
        PFCloud.callFunctionInBackground("purchase", withParameters: params) { (result, error) -> Void in
            if error == nil {
                print(result)
            } else {
                print(error)
            }
        }
    }
}
