//
//  NightsTableViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 28/01/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import Parse

class NightsTableViewController: UITableViewController,  UISearchBarDelegate, UISearchDisplayDelegate {
	
	var events: Array<AnyObject> = []
    var filteredEvents: Array<AnyObject> = []
    @IBOutlet weak var searchBar: UISearchBar!
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func searchDisplayController(controller: UISearchDisplayController, willShowSearchResultsTableView searchTableView: UITableView) {
        searchTableView.rowHeight = tableView.rowHeight
        searchTableView.estimatedRowHeight = 142.0
        searchTableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        searchBar.showsScopeBar = true
        SwiftSpinner.show("Getting Data", animated: true)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 142.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		let query = PFQuery(className: "Event")
        query.orderByAscending("date")
		query.findObjectsInBackgroundWithBlock({(NSArray objects, NSError error) in
			if (error != nil) {
				NSLog("error " + error!.localizedDescription)
			}
			else {
				self.events = NSArray(array: objects!) as Array<AnyObject>
				self.tableView.reloadData()
			}
		})
        
        SwiftSpinner.hide()
	}
	

    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        // Filter the array using the filter method
        self.filteredEvents = self.events.filter()
            {
                var nameMatch: Bool = false
                let descMatch: Bool = false
                var authorMatch: Bool = false
                var themeMatch: Bool = false
                var scopeMatch: Bool = true
                if (scope == "Passé")
                {
                    if let date = ($0 as! PFObject)["date"] as? NSDate {
                        let nowDate = NSDate()
                        if date.isGreaterThanDate(nowDate)
                        {
                            return false
                        }
                        if (scope != "All" && searchText == "")
                        {
                            return true
                        }
                    }
                }
                if (scope == "A Venir")
                {
                    if let date = ($0 as! PFObject)["date"] as? NSDate {
                        let nowDate = NSDate()
                        if date.isLessThanDate(nowDate)
                        {
                            return false
                        }
                    }
                }
                if let name = ($0 as! PFObject)["name"] as? String {
                    nameMatch = (name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil)
                }
                if let author = ($0 as! PFObject)["author"] as? String {
                    authorMatch = (author.lowercaseString.rangeOfString(searchText.lowercaseString) != nil)
                }
                if let theme = ($0 as! PFObject)["theme"] as? String {
                    themeMatch = (theme.lowercaseString.rangeOfString(searchText.lowercaseString) != nil)
                }
               if let desc = ($0 as! PFObject)["Description"] as? String {
                    let descMatch = (desc.lowercaseString.rangeOfString(searchText.lowercaseString) != nil)
                }

                return (nameMatch || authorMatch || themeMatch || descMatch)
        }
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String?) -> Bool {
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles! as [String]
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        self.filterContentForSearchText(searchString!, scope: selectedScope)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        let scope = self.searchDisplayController!.searchBar.scopeButtonTitles! as [String]
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!, scope: scope[searchOption])
        return true
    }
	
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return filteredEvents.count
        } else {
            return events.count
        }
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCellWithIdentifier("NightCell", forIndexPath: indexPath) as! NightsTableViewCell

        if tableView == self.searchDisplayController!.searchResultsTableView {
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
            if self.searchDisplayController!.active {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow!.row
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