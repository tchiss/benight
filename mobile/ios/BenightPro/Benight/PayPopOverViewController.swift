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
    
    weak var master: NightDetailsTableViewController!
    @IBOutlet weak var PartyName: UILabel!
    @IBOutlet weak var paymentField2: STPPaymentCardTextField!
    @IBOutlet weak var TicketType: UILabel!
    @IBOutlet weak var TicketPrice: UILabel!
    var price: Int = 0
    
    override func viewDidLoad() {
        // add text field for fill card information
        super.viewDidLoad()
        paymentField2.delegate = self
        PartyName.text = master.EventTitle.title
        if master.SeletedVIP == false
        {
            self.price = master.event!["price"] as! Int
            TicketType.text = "Billet Normal"
        }
        else
        {
            self.price = master.event!["VipPrice"] as! Int
            TicketType.text = "Billet VIP"

        }
        TicketPrice.text = "Prix: " + String(price) + "€"
        paymentField2.textColor = UIColor.whiteColor()
        }
    
    func ErrorPopup(message: String)
    {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func OKPopup(message: String)
    {
        let alertController = UIAlertController(title: "Validation", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.cancel(nil)
        })
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func createToken() {
        let card = STPCard()
        card.expMonth = paymentField2.expirationMonth
        card.expYear = paymentField2.expirationYear
        card.number = paymentField2.cardNumber
        card.cvc = paymentField2.cvc
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
    @IBAction func BuyTicket(sender: AnyObject?) {
        SwiftSpinner.show("Transaction en Cours")
        createToken()
    }
    
    @IBAction func cancel(sender: AnyObject?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postStripeToken(token: STPToken) {
        
        let params: [String: NSObject] = ["stripeToken": token.tokenId,
            "amount": price ]
        PFCloud.callFunctionInBackground("purchase", withParameters: params) { (result, error) -> Void in
            if error == nil {
                print(result)
                self.master.GenerateTicket(true)
                SwiftSpinner.hide()
                self.OKPopup("Ticket Acheté Bravo !")
                
            } else {
                print(error)
                self.ErrorPopup((error?.description)!)
            }
        }
    }
}
