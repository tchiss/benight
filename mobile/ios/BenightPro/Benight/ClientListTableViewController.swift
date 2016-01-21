//
//  ClientListTableViewController.swift
//  Benight Pro
//
//  Created by Kevin VACQUIER on 18/01/2016.
//  Copyright © 2016 Benight. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import QRCodeKit
import AVFoundation

class ClientListTableViewController: UITableViewController, QRCodeCaptureCameraDelegate {

    weak var event: PFObject? = PFObject(className: "Event")
    var tickets: Array<AnyObject> = []
    var vip: Bool? = nil
    
    @IBOutlet weak var ScanTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        SwiftSpinner.show("Loading")
        let EventNameString : String = self.event!["name"] as! String
        if EventNameString.characters.count < 15
        {
            self.ScanTitle.title = "Normal - " + EventNameString
        }
        else
        {
            self.ScanTitle.title =  "VIP - " + EventNameString[0..<15]
        }
        let query = PFQuery(className: "Reservation")
        query.includeKey("User")
        query.includeKey("Tickets")
        query.whereKey("Event", equalTo: self.event!)
        if (vip == true)
        {
            let innerQuery = PFQuery(className: "Tickets")
            innerQuery.whereKey("VIP", equalTo: true)
            query.whereKey("Tickets", matchesQuery: innerQuery)
        }
        else if (vip == false)
        {
            let innerQuery = PFQuery(className: "Tickets")
            innerQuery.whereKey("VIP", notEqualTo: true)
            query.whereKey("Tickets", matchesQuery: innerQuery)
        }
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if (error != nil) {
                NSLog("error " + error!.localizedDescription)
                SwiftSpinner.hide()
            }
            else {
                self.tickets = NSArray(array: objects!) as! Array<AnyObject>
                self.tableView.reloadData()
                SwiftSpinner.hide()
            }
        })

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tickets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ClientCell", forIndexPath: indexPath)
        
        var resa = tickets[indexPath.row] as! PFObject
        var user = resa["User"] as! PFUser
        var ticket = resa["Tickets"] as! PFObject
        
        cell.textLabel!.text = user["name"] as? String
        cell.detailTextLabel?.text = user.username
        if (ticket["Check"] as? Bool == true)
        {
            cell.imageView?.image = UIImage(named: "Checked")
        }
        else
        {
            cell.imageView?.image = UIImage(named: "Circle")
        }
        return cell
    }
    
    func ErrorPopup(message: String)
    {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func TicketPopup(message: String)
    {
        let alertController = UIAlertController(title: "Scanned", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let captureViewController = segue.destinationViewController as? QRCodeCaptureViewController {
            captureViewController.delegate = self
        }
    }
    
    func qrCodeCaptureCamera(captureCamera: QRCodeCaptureCamera, didCaptureQRCodeMetadataObjects QRCodeMetadataObjects: [AVMetadataMachineReadableCodeObject]) {
        guard let qrCodeObject = QRCodeMetadataObjects.last else { return }
        
        print(qrCodeObject.stringValue)
        self.navigationController!.popViewControllerAnimated(true)
        //self.TicketPopup("Ticket Scanné")
        let query = PFQuery(className:"Tickets")
        query.includeKey("Reservation")
        query.getObjectInBackgroundWithId(qrCodeObject.stringValue) {
            (tickett: PFObject?, error: NSError?) -> Void in
            if error == nil && tickett != nil {
                if (tickett!["Reservation"]["Event"]!!.objectId != self.event?.objectId)
                {
                    self.ErrorPopup("Ticket Invalide pour cette soirée")
                }
                else if (tickett!["Check"] as? Bool != true)
                {
                    tickett!["Check"] = true
                    tickett?.saveInBackground()
                    if tickett!["VIP"] as? Bool == true
                    {
                        self.TicketPopup("Ticket VIP Validé. Passez une bonne soirée.")
                    }
                    else
                    {
                        self.TicketPopup("Ticket Normal Validé. Passez une bonne soirée.")
                        
                    }
                    self.tableView.reloadData()
                }
            } else {
                self.ErrorPopup("Ticket Invalide.")
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
