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
}
