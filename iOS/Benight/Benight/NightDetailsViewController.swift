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
        getTicketPassbook()
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
        self.presentViewController(passcontroller, animated: true, completion: nil)
    }
    
    func getTicketPassbook()
    {
        let TicketID: String  = self.reservation["Tickets"]!.objectId as String!
        println(TicketID)
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://tickets.benight.cc/")!)
        request.HTTPMethod = "POST"
        let postString: String = "ObjectId=" + TicketID + "&authKey=\"KNfCMt9TUSgYBfg\""
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            println("response = \(response)")
            if (error == nil) {
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                if (statusCode == 200)
                {
                    println("Success: \(statusCode)")
                    var pkfile : NSData = NSData(data: data)
                    var error2: NSError?
                    var pass: PKPass = PKPass(data: data, error: &error2)
                    if (error2 == nil)
                    {
                        self.openPass(pass)
                    }
                }
            }
            else {
                // Failure
                println("Failure: %@", error.localizedDescription);
            }
        })
        task.resume()
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
