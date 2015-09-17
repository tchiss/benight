//
//  MyMenuTableViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    
	var selectedMenuItem : Int = 1
    
    //override func shouldAutorotate() -> Bool {
    //    return false
    //}
    
   // override func supportedInterfaceOrientations() -> Int {
   //         return Int(UIInterfaceOrientationMask.Portrait.rawValue)
   // }
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Customize apperance of table view
		tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) //
		tableView.scrollsToTop = false
		tableView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.5)
		// Preserve selection between presentations
		self.clearsSelectionOnViewWillAppear = false
		
		tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections.
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Return the number of rows in the section.
		return 4
    }
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
		
		if (cell == nil) {
			cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
			cell!.backgroundColor = UIColor.clearColor()
			cell!.textLabel?.textColor = UIColor.whiteColor()
			let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
			selectedBackgroundView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.5)
			cell!.selectedBackgroundView = selectedBackgroundView
		}
		switch (indexPath.row) {
		case 0:
			cell!.imageView?.image = UIImage(named: "helpIcon")
			cell!.textLabel?.text = "Profil"
			break
		case 1:
			cell!.imageView?.image = UIImage(named: "helpIcon")
			cell!.textLabel?.text = "Les Soirées"
			break
		case 2:
			cell!.imageView?.image = UIImage(named: "helpIcon")
			cell!.textLabel?.text = "Mes Soirées"
			break
		default:
			cell!.imageView?.image = UIImage(named: "helpIcon")
			cell!.textLabel?.text = "Agenda"
			break
		}
		return cell!
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 50.0
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if (indexPath.row == selectedMenuItem) {
			return
		}
		selectedMenuItem = indexPath.row
		
		//Present new view controller
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
		var destViewController : UIViewController
		switch (indexPath.row) {
		case 0:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ProfileView") as! UIViewController
			break
		case 1:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NightsView") as! UIViewController
			break
		case 2:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MyNightsView") as! UIViewController
			break
        default:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("AgendaView") as! UIViewController
			break
		}
		sideMenuController()?.setContentViewController(destViewController)
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
	}
	*/
	
}
