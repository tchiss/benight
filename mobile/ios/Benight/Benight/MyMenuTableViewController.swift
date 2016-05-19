//
//  MyMenuTableViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit
import Parse

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
		return 7
    }
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as UITableViewCell!
		
		if (cell == nil) {
			cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
			cell!.backgroundColor = UIColor.clearColor()
			cell!.textLabel?.textColor = UIColor.whiteColor()
			let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
			selectedBackgroundView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
			cell!.selectedBackgroundView = selectedBackgroundView
		}
		switch (indexPath.row) {
		case 0:
			cell!.imageView?.image = UIImage(named: "profile")
			cell!.textLabel?.text = "Mon Profil"
			break
		case 1:
			cell!.imageView?.image = UIImage(named: "event")
			cell!.textLabel?.text = "Les Soirées"
            break
        case 2:
                cell!.imageView?.image = UIImage(named: "past")
                cell!.textLabel?.text = "Soirées passées"
            break
		case 3:
			cell!.imageView?.image = UIImage(named: "ticket")
			cell!.textLabel?.text = "Mes Soirées"
			break
        case 4:
            cell!.imageView?.image = UIImage(named: "News")
            cell!.textLabel?.text = "Les News"
            break
        case 5:
            cell!.imageView?.image = UIImage(named: "Contact")
            cell!.textLabel?.text = "Contact"
        case 6:
            cell!.imageView?.image = UIImage(named: "About")
            cell!.textLabel?.text = "À Propos"
            break
        default:
			cell!.imageView?.image = UIImage(named: "logout")
			cell!.textLabel?.text = "Déconnection"
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
        var LogOut: Bool = false
		var destViewController : UIViewController
		switch (indexPath.row) {
		case 0:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ProfileView")
			break
		case 1:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NightsView") 
			break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("PastNightsView")
            break
		case 3:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MyNightsView") 
			break
        case 4:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NewsView")
            break
        case 5:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Contact")
            break
        case 6:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("About")
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Connexion")
            LogOut = true
			break
		}
        if (LogOut)
        {
            PFUser.logOut()
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
