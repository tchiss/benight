//
//  NightDetailsViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 25/02/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import PassKit
import Alamofire

class NightDetailsViewController: UIViewController, PKAddPassesViewControllerDelegate {

	var event: PFObject = PFObject(className: "Event")
    var reservation: PFObject = PFObject(className: "Reservation")

    
	@IBOutlet var switchInsc: UISwitch!
	@IBOutlet var inscLabel: UILabel!
	@IBOutlet var DateLabel: UILabel!
	@IBOutlet var descLabel: UILabel!
	@IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var AddPassbookButton: UIButton!
	
	@IBAction func switchChanger(sender: AnyObject) {
		if (switchInsc.on)
		{
			inscLabel.text = "Inscrit"
			var resa = PFObject(className:"Reservation")
			resa["User"] = PFUser.currentUser()
			resa["Event"] = event
			resa.save()
            self.reservation = resa
            self.GenerateTicket()
            AddPassbookButton.hidden = false
		}
	}

    @IBAction func AddToPassbook(sender: AnyObject) {
        SwiftSpinner.show("Downloading Your Ticket")
        getTicketPassbook(0)
    }
    
	func switchStatusChanger() {
		if (switchInsc.on)
		{
			inscLabel.text = "Non Inscrit"
			switchInsc.setOn(false, animated: false)
		}
		else
		{
			inscLabel.text = "Inscrit"
			switchInsc.setOn(true, animated: false)
            switchInsc.hidden = true
            AddPassbookButton.hidden = false
		}
		
	}
    
    func ErrorPopup(message: String)
    {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func GenerateTicket () {
            if let Event: PFObject = self.reservation["Event"] as? PFObject
            {
                let EventNameString : String = Event["name"] as! String
                var Ticket = PFObject(className:"Tickets")
                Ticket["Reservation"] = reservation
                Ticket["User"] = PFUser.currentUser()
                Ticket["EventName"] = EventNameString[0..<15]
                Ticket["EventPlace"] = Event["author"]
                Ticket["Date"] = Event["date"]
                Ticket.save()
                self.reservation["Tickets"] = Ticket
                self.reservation.save()
            }
    }
    
    func openPass(pass: PKPass)
    {
        let passname = "Benight Ticket"
        var passcontroller = PKAddPassesViewController(pass: pass)
        passcontroller.delegate = self
        SwiftSpinner.hide()
        self.presentViewController(passcontroller, animated: true, completion: nil)
    }
    
    
    func getTicketPassbook(inc: Int)
    {
        let TicketID: String  = self.reservation["Tickets"]!.objectId as String!
        var ticketGetted: Bool = false
            Alamofire.request(.POST, "https://tickets.benight.cc", parameters: ["ObjectId":TicketID, "authKey":"\"KNfCMt9TUSgYBfg\""]).response{ (request, response, data, error) in
                if (error == nil)
                {
                    let statusCode = response!.statusCode
                    if (statusCode == 200)
                    {
                        println("Success: \(statusCode)")
                        var pkfile : NSData = NSData(data: data!)
                        var error2: NSError?
                        var pass: PKPass? = PKPass(data: data, error: &error2)
                        if (error2 == nil)
                        {
                            ticketGetted = true
                            self.openPass(pass!)
                        }
                    }
                }
                else {
                    println("Failure: %@", error!.localizedDescription);
                }
                if (inc < 6 && ticketGetted == false)
                {
                    self.getTicketPassbook(inc + 1)
                }
                else if (ticketGetted == false)
                {
                    SwiftSpinner.hide()
                    self.ErrorPopup("Can not get your Ticket. Please try again later")
                }
        }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		nameLabel.text = event["name"] as! String!
		//cell.PlaceLabel.text = events[indexPath.row]["location"] as String!
		descLabel.text = event["theme"] as! String!
		//DateLabel.text = (event["date"] as! NSDate!).description
		var query = PFQuery(className: "Reservation")
		query.includeKey("Event")
		query.whereKey("User", equalTo: PFUser.currentUser()!)
		query.whereKey("Event", equalTo: event)
		query.findObjectsInBackgroundWithBlock(
			{
				(objects: [AnyObject]?, NSError error) in
				if (error != nil) {
					NSLog("error " + error!.localizedDescription)
				}
				else {
					if let objects = objects as? [PFObject] {
						if (objects.count != 0)
						{
							self.switchStatusChanger()
                            self.reservation = objects[0]
						}
					}
				}
		})
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
