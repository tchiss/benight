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
import QRCodeKit
import AVFoundation

class NightDetailsTableViewController: UITableViewController, PKAddPassesViewControllerDelegate, UIPopoverPresentationControllerDelegate, QRCodeCaptureCameraDelegate {

    weak var event: PFObject? = PFObject(className: "Event")
    weak var reservation: PFObject? = PFObject(className: "Reservation")
    var HasTicket:  Bool = false
    weak var popOver: PayPopOverViewController? = PayPopOverViewController()
    weak var Ticket1: PFObject? = nil
    var SeletedVIP: Bool = false
    
    @IBOutlet weak var imgCell: UITableViewCell!
    @IBOutlet weak var DescCell: UITableViewCell!
    @IBOutlet weak var MapButton: UIBarButtonItem!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet weak var EventTitle: UINavigationItem!
    
    @IBOutlet weak var desc: UITextView!
    
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
    
    func TicketPopup(message: String)
    {
        let alertController = UIAlertController(title: "Scanned", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        SwiftSpinner.show("Getting Data", animated: true)
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
                            //self.FlyerImage.image = image
                        }
                    }
                }
            }
        }
        DateLabel.text = formatter.stringFromDate(event!["date"] as! NSDate!)
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
        
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
       if segue.identifier ==  "ShowList"
        {
            let vc = segue.destinationViewController as! ClientListTableViewController
            vc.event = self.event
        }
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
