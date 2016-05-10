//
//  NewsTableViewController.swift
//  Benight
//
//  Created by Kevin VACQUIER on 28/03/2016.
//  Copyright © 2016 Benight. All rights reserved.
//

import UIKit
import Parse

class NewsCellNoImage: UITableViewCell {
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Text2: UITextView!
    @IBOutlet weak var Author: UILabel!
    
}

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Text2: UITextView!
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var Image2: UIImageView!

}

class NewsTableViewController: UITableViewController {
    var news: Array<PFObject> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        SwiftSpinner.show("Chargement", animated: true)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 142.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        let query = PFQuery(className: "News")
        query.includeKey("Creator")
        query.findObjectsInBackgroundWithBlock({(objects, error) in
            if (error != nil) {
                NSLog("error " + error!.localizedDescription)
            }
            else {
                self.news = NSArray(array: objects!) as! Array<PFObject>
                self.tableView.reloadData()
            }
        })
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
        // #warnnewng Incomplete implementation, return the number of rows
        return news.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let theNews = news[indexPath.row]
        if let userImageFile = theNews["Image"] as? PFFile
        {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        cell.Image2.image = image
                    }
                }
            }
            cell.Title.text = theNews["Title"] as? String
            cell.Text2.text = theNews["Text"] as? String
            cell.Author.text = (theNews["Creator"] as! PFObject)["username"] as? String
            cell.Text2.textColor = UIColor.whiteColor()
            return cell
        }
        else {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("NewsCellNoImage", forIndexPath: indexPath) as! NewsCellNoImage
            cell.Title.text = theNews["Title"] as? String
            cell.Text2.text = theNews["Text"] as? String
            cell.Author.text = (theNews["Creator"] as! PFObject)["username"] as? String
            cell.Text2.textColor = UIColor.whiteColor()
            return cell
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
