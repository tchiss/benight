//
//  NightsTableViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 28/01/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import Parse

class PastNightsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate,UISearchBarDelegate {
	
	var events: Array<AnyObject> = []
    var filteredEvents: Array<AnyObject> = []
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    @IBOutlet var segView: UITableViewHeaderFooterView!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var resultSearchController = UISearchController()

    @IBAction func changedSize(sender: AnyObject) {
        SwiftSpinner.show("Getting Data", animated: true)
        let query = PFQuery(className: "Event")
        query.orderByAscending("date")
        let now = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let midnightOfToday = cal!.startOfDayForDate(now)
        query.whereKey("date", lessThan: midnightOfToday)
        switch segmentedControl.selectedSegmentIndex{
        case 1:
            query.whereKey("location", nearGeoPoint: GlobalVariables.sharedManager.userLoc!, withinKilometers: 5)
            break
        case 2 :
            query.whereKey("location", nearGeoPoint: GlobalVariables.sharedManager.userLoc!, withinKilometers: 10)
            break
        case 3 :
            query.whereKey("location", nearGeoPoint: GlobalVariables.sharedManager.userLoc!, withinKilometers: 15)
            break
        case 4 :
            query.whereKey("location", nearGeoPoint: GlobalVariables.sharedManager.userLoc!, withinKilometers: 50)
            break
        default :
            print("all")
            break
        }
        query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
            if (error != nil) {
                NSLog("error " + error!.localizedDescription)
                SwiftSpinner.hide()
            }
            else {
                self.events = NSArray(array: objects!) as Array<AnyObject>
                self.tableView.reloadData()
                SwiftSpinner.hide()
            }
        })
        
    }
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.definesPresentationContext = false
        SwiftSpinner.show("Getting Data", animated: true)
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.resultSearchController.searchBar.barStyle = UIBarStyle.Black
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                GlobalVariables.sharedManager.userLoc = geoPoint
            }
        }
        tableView.estimatedRowHeight = 142.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		let query = PFQuery(className: "Event")
        query.orderByAscending("date")
        let now = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let midnightOfToday = cal!.startOfDayForDate(now)
        query.whereKey("date", lessThan: midnightOfToday)
		query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
			if (error != nil) {
				NSLog("error " + error!.localizedDescription)
                SwiftSpinner.hide()
			}
			else {
				self.events = NSArray(array: objects!) as Array<AnyObject>
				self.tableView.reloadData()
                SwiftSpinner.hide()
			}
		})
        
	}
	

    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredEvents.removeAll()
        let searchText = searchController.searchBar.text
        var nameMatch: Bool = false
        var descMatch: Bool = false
        var authorMatch: Bool = false
        var themeMatch: Bool = false
        for ev in events
        {
        if let name = (ev as! PFObject)["name"] as? String {
            nameMatch = (name.lowercaseString.rangeOfString(searchText!.lowercaseString) != nil)
        }
        if let author = (ev as! PFObject)["author"] as? String {
            authorMatch = (author.lowercaseString.rangeOfString(searchText!.lowercaseString) != nil)
        }
        if let theme = (ev as! PFObject)["theme"] as? String {
            themeMatch = (theme.lowercaseString.rangeOfString(searchText!.lowercaseString) != nil)
        }
        if let desc = (ev as! PFObject)["Description"] as? String {
            descMatch = (desc.lowercaseString.rangeOfString(searchText!.lowercaseString) != nil)
            }
        if (nameMatch || authorMatch || themeMatch || descMatch)
        {
            filteredEvents.append(ev)
        }
        }
        self.tableView.reloadData()
    }

	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return filteredEvents.count
        }
        else {
            return events.count
        }
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCellWithIdentifier("NightCell", forIndexPath: indexPath) as! NightsTableViewCell

        if self.resultSearchController.active {
            cell.fillCell(filteredEvents[indexPath.row])
        } else {
            cell.fillCell(events[indexPath.row])
        }
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier ==  "myNightDetails"
		{
            let vc = segue.destinationViewController as! NightDetailsTableViewController
            if self.resultSearchController.active {
                let indexPath = self.tableView.indexPathForSelectedRow!.row
                let object = filteredEvents[indexPath] as! PFObject
                vc.event = object
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow!.row
                let object = events[indexPath] as! PFObject
                vc.event = object
            }
        }
	}
}