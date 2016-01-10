//
//  NightDetailsTableViewController.swift
//  Benight
//
//  Created by Kevin VACQUIER on 12/11/2015.
//  Copyright © 2015 Benight. All rights reserved.
//

import UIKit
import PassKit
import Alamofire

class NightDetailsTableViewController: UITableViewController, PKAddPassesViewControllerDelegate, UIPopoverPresentationControllerDelegate {

    var event: PFObject = PFObject(className: "Event")
    var reservation: PFObject = PFObject(className: "Reservation")
    var HasTicket:  Bool = false
    
    @IBOutlet weak var SoundcloudCell: UITableViewCell!
    @IBOutlet weak var AlbumCell: UITableViewCell!
    @IBOutlet weak var imgCell: UITableViewCell!
    @IBOutlet weak var DescCell: UITableViewCell!
    @IBOutlet weak var MapButton: UIBarButtonItem!
    @IBOutlet weak var TicketCell: UITableViewCell!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet weak var EventTitle: UINavigationItem!
    @IBOutlet weak var AlbumButton: UIButton!
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var TicketButton: UIButton!
    @IBOutlet weak var desc: UITextView!
    
    override func viewDidAppear(animated: Bool) {
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }

    func ErrorPopup(message: String)
    {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func BuyOrGetTicket(let sender: AnyObject) {
        if HasTicket
        {
            SwiftSpinner.show("Downloading Your Ticket")
            getTicketPassbook(0)
        }
        else
        {
            if (event["price"]! as! Int == 0)
            {
                let resa = PFObject(className:"Reservation")
                resa["User"] = PFUser.currentUser()
                resa["Event"] = event
                do {
                    try resa.save()
                }
                catch{
                    print(error)
                }
                self.reservation = resa
                self.GenerateTicket(true)
                HasTicket = true
                self.TicketButton.setTitle("Télécharger le ticket", forState: .Normal)
            }
            else
            {
                let resa = PFObject(className:"Reservation")
                resa["User"] = PFUser.currentUser()
                resa["Event"] = event
                do {
                    try resa.save()
                }
                catch{
                    print(error)
                }
                self.reservation = resa
                self.GenerateTicket(false)
                self.TicketButton.setTitle("Télécharger le ticket", forState: .Normal)
                self.performSegueWithIdentifier("payPopOver", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "background"),
            forBarMetrics: .Default)
        
        SwiftSpinner.show("Getting Data", animated: true)

        let EventNameString : String = self.event["name"] as! String
        if EventNameString.characters.count < 15
        {
            self.EventTitle.title = EventNameString
        }
        else
        {
            self.EventTitle.title = EventNameString[0..<15]
        }
        
        desc.text = event["Description"] as? String
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        DateLabel.text = formatter.stringFromDate(event["date"] as! NSDate!)
        let query = PFQuery(className: "Reservation")
        query.includeKey("Event")
        query.whereKey("User", equalTo: PFUser.currentUser()!)
        query.whereKey("Event", equalTo: event)
        query.findObjectsInBackgroundWithBlock(
            {
                (objects: [PFObject]?, NSError error) in
                if (error != nil) {
                    NSLog("error " + error!.localizedDescription)
                }
                else {
                    if let objects = objects as [PFObject]? {
                        if (objects.count != 0)
                        {
                            self.TicketButton.setTitle("Télécharger le ticket", forState: .Normal)
                            self.HasTicket = true
                            self.reservation = objects[0]
                        }
                    }
                }
        })

        if (self.event["Album"] == nil) {
            AlbumCell.hidden = true
        }
        if (event["SoundCloud"] == nil)
        {
            SoundcloudCell.hidden = true
        }
        else
        {
            let url = NSURL(string: "https://tickets.benight.cc/soundcloud.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            var bodyData: String = "authKey=TheIslandOfMusic&ObjectId=" + event["SoundCloud"].objectId!!
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
            webView.loadRequest(request)
        }
        SwiftSpinner.hide()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func GenerateTicket (paid: Bool) {
        if let Event: PFObject = self.reservation["Event"] as? PFObject
        {
            let EventNameString : String = Event["name"] as! String
            let Ticket = PFObject(className:"Tickets")
            Ticket["Reservation"] = reservation
            Ticket["User"] = PFUser.currentUser()
            Ticket["EventName"] = EventNameString[0..<15]
            Ticket["EventPlace"] = Event["author"]
            Ticket["Date"] = Event["date"]
            Ticket["paid"] = paid
            do {
                try Ticket.save()
            }
            catch {
                print(error)
            }
            self.reservation["Tickets"] = Ticket
            do {
                try self.reservation.save()
            }
            catch {
                print(error)
            }
        }
    }

    func openPass(pass: PKPass)
    {
        _ = "Benight Ticket"
        let passcontroller = PKAddPassesViewController(pass: pass)
        passcontroller.delegate = self
        SwiftSpinner.hide()
        self.presentViewController(passcontroller, animated: true, completion: nil)
    }
    
    func getTicketPassbook(inc: Int)
    {
        let TicketID: String  = self.reservation["Tickets"]!.objectId as String!
        var ticketGetted: Bool = false
        Alamofire.request(.POST, "https://tickets.benight.cc", parameters: ["ObjectId":TicketID, "authKey":"KNfCMt9TUSgYBfg"]).response{ (request, response, data, error) in
            if (error == nil)
            {
                let statusCode = response!.statusCode
                if (statusCode == 200)
                {
                    print("Success: \(statusCode)")
                    var pkfile : NSData = NSData(data: data!)
                    var error2: NSError?
                    var pass: PKPass?
                    do {
                        pass = try PKPass(data: data!, error: nil)
                    } catch let error as NSError {
                        error2 = error
                        pass = nil
                    } catch {
                        fatalError()
                    }
                    if (error2 == nil)
                    {
                        ticketGetted = true
                        self.openPass(pass!)
                    }
                }
            }
            else {
                print("Failure: %@", error.debugDescription);
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier ==  "ShowAlbum"
        {
            let album = event["Album"] as! PFObject
            let vc = segue.destinationViewController as! AlbumPhotosViewController
            vc.album = album
        }
        else if segue.identifier == "ShowMap"
        {
            let descLocation: PFGeoPoint = event["location"] as! PFGeoPoint
            let placeTitle: String = event["author"] as! String
            let eventTitle: String = event["name"] as! String
            let vc = segue.destinationViewController as! NightMapViewController
            vc.eventTitle = eventTitle
            vc.placeTitle  = placeTitle
            vc.descLocation = descLocation
        }
        if segue.identifier == "payPopOver" {
            if let controller = segue.destinationViewController as? PayPopOverViewController {
                controller.popoverPresentationController!.delegate = self
                controller.preferredContentSize = CGSize(width: 320, height: 186)
            }
        }
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
