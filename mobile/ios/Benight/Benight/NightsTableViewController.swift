//
//  NightsTableViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 28/01/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit

class NightsTableViewController: UITableViewController {
	
	var events: Array<AnyObject> = []
	
<<<<<<< HEAD
<<<<<<< HEAD
	override func viewDidLoad() {
		super.viewDidLoad()
				self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		var query = PFQuery(className: "Event")
		query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
			if (error != nil) {
				NSLog("error " + error.localizedDescription)
			}
			else {
				self.events = NSArray(array: objects)
=======
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
    override func shouldAutorotate() -> Bool {
        return false
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 142.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

		var query = PFQuery(className: "Event")
		query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
			if (error != nil) {
				NSLog("error " + error!.localizedDescription)
			}
			else {
				self.events = NSArray(array: objects!) as Array<AnyObject>
<<<<<<< HEAD
>>>>>>> master
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
				self.tableView.reloadData()
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
		// #warning Potentially incomplete method implementation.
		// Return the number of sections.
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete method implementation.
		// Return the number of rows in the section.
		return events.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
<<<<<<< HEAD
<<<<<<< HEAD
		let cell = tableView.dequeueReusableCellWithIdentifier("NightCell", forIndexPath: indexPath) as NightsTableViewCell
=======
		let cell = tableView.dequeueReusableCellWithIdentifier("NightCell", forIndexPath: indexPath) as! NightsTableViewCell
>>>>>>> master
=======
		let cell = tableView.dequeueReusableCellWithIdentifier("NightCell", forIndexPath: indexPath) as! NightsTableViewCell
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd

		cell.fillCell(events[indexPath.row])
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier ==  "nightDetails"
		{
			let indexPath = self.tableView.indexPathForSelectedRow()!.row
<<<<<<< HEAD
<<<<<<< HEAD
			let object = events[indexPath]
			let vc = segue.destinationViewController as NightDetailsViewController
			vc.event = object as PFObject
=======
			let object = events[indexPath] as! PFObject
			let vc = segue.destinationViewController as! NightDetailsViewController
			vc.event = object
>>>>>>> master
=======
			let object = events[indexPath] as! PFObject
			let vc = segue.destinationViewController as! NightDetailsViewController
			vc.event = object
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
		}
	}
	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return NO if you do not want the specified item to be editable.
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
	// Return NO if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	}
	*/
	
}