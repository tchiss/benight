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
import Parse

class NightDetailsTableViewController: UITableViewController, PKAddPassesViewControllerDelegate, UIPopoverPresentationControllerDelegate {

    var event: PFObject? = PFObject(className: "Event")
    var reservation: PFObject? = PFObject(className: "Reservation")
    var HasTicket:  Bool = false
    weak var popOver: PayPopOverViewController? = PayPopOverViewController()
    var Ticket1: PFObject? = nil
    var SeletedVIP: Bool = false
    
    @IBOutlet weak var SoldOutVIP: UIImageView!
    @IBOutlet weak var SoldOut: UIImageView!
    @IBOutlet weak var SoundcloudCell: UITableViewCell!
    @IBOutlet weak var AlbumCell: UITableViewCell!
    @IBOutlet weak var imgCell: UITableViewCell!
    @IBOutlet weak var DescCell: UITableViewCell!
    @IBOutlet weak var MapButton: UIBarButtonItem!
    @IBOutlet weak var TicketCell: UITableViewCell!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet weak var EventTitle: UINavigationItem!
    @IBOutlet weak var AlbumButton: UIButton!
    
    @IBOutlet weak var VIPCell: UITableViewCell!
    @IBOutlet weak var FlyerImage: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var TicketButton: UIButton!
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var TicketVipButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        desc.scrollEnabled = true
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
            SwiftSpinner.show("Chargement du Ticket")
            getTicketPassbook(0)
        }
        else
        {
            if (event!["price"]! as? Int == 0)
            {
                self.GenerateTicket(true)
                HasTicket = true
                buttonwallet()
            }
            else if (event!["price"]! as? Int == nil)
            {
                self.GenerateTicket(true)
                HasTicket = true
                buttonwallet()
            }
            else
            {
                self.performSegueWithIdentifier("payPopOver", sender: nil)
            }
        }
    }

    func buttonwallet()
    {
        self.TicketButton.setImage(UIImage(named: "Pass"), forState: .Normal)
        self.TicketButton.setTitle("", forState: .Normal)
        SwiftSpinner.hide()
    }
    
    override func viewDidLoad() {
        SwiftSpinner.show("Chargement", animated: true)
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "background"),
            forBarMetrics: .Default)
        

        let EventNameString : String = self.event!["name"] as! String
        if EventNameString.characters.count < 15
        {
            self.EventTitle.title = EventNameString
        }
        else
        {
            self.EventTitle.title = EventNameString[0..<15]
        }
        desc.textContainerInset = UIEdgeInsetsZero;
        desc.textContainer.lineFragmentPadding = 0;
        desc.scrollEnabled = false
        desc.text = event!["Description"] as? String
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        formatter.locale = NSLocale(localeIdentifier: "fr_FR")
        if (event!["Flyer"] != nil)
        {
            if let userImageFile = event!["Flyer"] as? PFFile
            {
                userImageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            let image = UIImage(data:imageData)
                            self.FlyerImage.image = image
                        }
                    }
                }
            }
        }
        
        DateLabel.text = formatter.stringFromDate(event!["date"] as! NSDate!)
        let query = PFQuery(className: "Reservation")
        query.includeKey("Event")
        query.includeKey("Tickets")
        query.whereKey("User", equalTo: PFUser.currentUser()!)
        query.whereKey("Event", equalTo: event!)
        query.findObjectsInBackgroundWithBlock(
            {
                (objects: [PFObject]?, error) in
                if (error != nil) {
                    NSLog("error " + error!.localizedDescription)
                }
                else {
                    if let objects = objects as [PFObject]? {
                        if (objects.count != 0)
                        {
                            self.buttonwallet()
                            self.HasTicket = true
                            self.reservation = objects[0]
                            print(self.reservation)
                        }
                        else if self.event!["price"] == nil
                        {
                            self.TicketButton.setTitle("Obtenir un Ticket Gratuit", forState: UIControlState.Normal)
                        }
                        else if self.event!["price"] as! Int == 0
                        {
                            self.TicketButton.setTitle("Obtenir un Ticket Gratuit", forState: UIControlState.Normal)
                        }
                        else
                        {
                            self.TicketButton.setTitle("Acheter un Ticket à " + String(self.event!["price"]) + "€.", forState: UIControlState.Normal)
                        }
                        if (self.HasTicket == false)
                        {
                            if let left = self.event!["PlaceLeft"] as? Int
                            {
                                if left == 0
                                {
                                    self.SoldOut.hidden = false
                                    self.TicketButton.userInteractionEnabled = false
                                }
                            }
                            if let vip = self.event!["VIP"] as? Bool
                            {
                                if vip == true
                                {
                                    self.VIPCell.hidden = false
                                    if let vipleft = self.event!["PlaceVipLeft"] as? Int
                                    {
                                        if vipleft == 0
                                        {
                                            self.TicketVipButton.setTitle("Acheter un Ticket VIP à " + String(self.event!["VipPrice"]) + "€.", forState: UIControlState.Normal)
                                            self.SoldOutVIP.hidden = false
                                            self.TicketVipButton.userInteractionEnabled = false
                                            self.tableView.reloadData()
                                            SwiftSpinner.hide()
                                        }
                                        else
                                        {
                                            self.TicketVipButton.setTitle("Acheter un Ticket VIP à " + String(self.event!["VipPrice"]) + "€.", forState: UIControlState.Normal)
                                            self.tableView.reloadData()
                                            SwiftSpinner.hide()
                                        }
                                    }
                                }
                            }
                            SwiftSpinner.hide()
                        }
                    }
                }
                let now = NSDate()
                if (now.compare((self.event!["date"] as? NSDate)!) == NSComparisonResult.OrderedDescending && self.HasTicket != true)
                {
                    self.TicketCell.hidden = true
                    self.VIPCell.hidden = true
                    self.tableView.reloadData()
                }
        })

        if (self.event!["Album"] == nil) {
            AlbumCell.hidden = true
        }
        if (event!["SoundCloud"] == nil)
        {
            SoundcloudCell.hidden = true
        }
        else
        {
            let url = NSURL(string: "https://tickets.benight.cc/soundcloud.php")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            let bodyData: String = "authKey=TheIslandOfMusic&ObjectId=" + event!["SoundCloud"].objectId!!
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
            webView.loadRequest(request)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func GenerateTicket (paid: Bool) {
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
        if let Event: PFObject = self.reservation!["Event"] as? PFObject
        {
            let EventNameString : String = Event["name"] as! String
    
            let Ticket = PFObject(className:"Tickets")
            Ticket["Reservation"] = reservation
            Ticket["User"] = PFUser.currentUser()
            if (EventNameString.characters.count <= 15)
            {
                Ticket["EventName"] = EventNameString
            }
            else
            {
                Ticket["EventName"] = EventNameString[0..<15]
            }
            Ticket["EventPlace"] = Event["author"]
            Ticket["Date"] = Event["date"]
            Ticket["paid"] = paid
            Ticket["VIP"] = self.SeletedVIP
            if (self.SeletedVIP)
            {
                event!["PlaceVipLeft"] = event!["PlaceVipLeft"] as! Int - 1
            }
            else
            {
                event!["PlaceLeft"] = event!["PlaceLeft"] as! Int - 1
            }
            do {
                try event!.save()
                try Ticket.save()
            }
            catch {
                print(error)
            }
            self.reservation!["Tickets"] = Ticket
            do {
                try self.reservation!.save()
                Ticket1 = Ticket
                HasTicket = true
                self.buttonwallet()
                self.VIPCell.hidden = true
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
        passcontroller.view.backgroundColor = UIColor.blackColor()
        passcontroller.delegate = self
        SwiftSpinner.hide()
        self.presentViewController(passcontroller, animated: true, completion: nil)
    }
    
    func getTicketPassbook(inc: Int)
    {
        print(self.reservation)
        let Ticket = self.reservation!["Tickets"] as! PFObject
        do {
            try Ticket.fetch()
        }
        catch {
            print(error)
            return
        }
        let TicketID: String  = self.reservation!["Tickets"]!.objectId as String!
        var ticketGetted: Bool = false
        Alamofire.request(.POST, "https://tickets.benight.cc", parameters: ["ObjectId":TicketID, "authKey":"KNfCMt9TUSgYBfg"]).response{ (request, response, data, error) in
            if (error == nil)
            {
                let statusCode = response!.statusCode
                if (statusCode == 200)
                {
                    print("Success: \(statusCode)")
                    var pass: PKPass?
                        pass =  PKPass(data: data!, error: nil)
                    if (pass != nil)
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
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0)
        {
            return 2
        }
        else if (section == 1)
        {
            if (self.VIPCell.hidden == true && self.TicketCell.hidden == true)
            {
                return 0
            }
            else if (self.VIPCell.hidden == true || self.TicketCell.hidden == true)
            {
                return 1
            }
            return 2
        }
        return 2
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier ==  "ShowAlbum"
        {
            let album = event!["Album"] as! PFObject
            let vc = segue.destinationViewController as! AlbumPhotosViewController
            vc.album = album
        }
        else if segue.identifier == "ShowMap"
        {
            let descLocation: PFGeoPoint = event!["location"] as! PFGeoPoint
            let placeTitle: String = event!["author"] as! String
            let eventTitle: String = event!["name"] as! String
            let vc = segue.destinationViewController as! NightMapViewController
            vc.eventTitle = eventTitle
            vc.placeTitle  = placeTitle
            vc.descLocation = descLocation
        }
        if segue.identifier == "payPopOver" {
            if let controller = segue.destinationViewController as? PayPopOverViewController {
                self.popOver = controller
                controller.master = self
                self.SeletedVIP = false
                controller.popoverPresentationController!.delegate = self
            }
        }
        if segue.identifier == "payVipPopOver" {
            if let controller = segue.destinationViewController as? PayPopOverViewController {
                self.popOver = controller
                controller.master = self
                self.SeletedVIP = true
                controller.popoverPresentationController!.delegate = self
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
