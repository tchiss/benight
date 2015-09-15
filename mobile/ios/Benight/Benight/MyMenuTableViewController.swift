//
//  MyMenuTableViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
<<<<<<< HEAD
<<<<<<< HEAD
	var selectedMenuItem : Int = 1
=======
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
    
	var selectedMenuItem : Int = 1
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
            return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    
<<<<<<< HEAD
>>>>>>> master
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Customize apperance of table view
<<<<<<< HEAD
<<<<<<< HEAD
		tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0) //
		tableView.scrollsToTop = false
		
=======
		tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) //
		tableView.scrollsToTop = false
		tableView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.5)
>>>>>>> master
=======
		tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) //
		tableView.scrollsToTop = false
		tableView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.5)
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
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
<<<<<<< HEAD
<<<<<<< HEAD
		return 5
	}
=======
		return 4
    }
>>>>>>> master
=======
		return 4
    }
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
		
		if (cell == nil) {
			cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
			cell!.backgroundColor = UIColor.clearColor()
<<<<<<< HEAD
<<<<<<< HEAD
			cell!.textLabel?.textColor = UIColor.whiteColor		()
			let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
			selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
=======
			cell!.textLabel?.textColor = UIColor.whiteColor()
			let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
			selectedBackgroundView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.5)
>>>>>>> master
=======
			cell!.textLabel?.textColor = UIColor.whiteColor()
			let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
			selectedBackgroundView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.5)
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
			cell!.selectedBackgroundView = selectedBackgroundView
		}
		switch (indexPath.row) {
		case 0:
			cell!.imageView?.image = UIImage(named: "helpIcon")
			cell!.textLabel?.text = "Profil"
			break
		case 1:
			cell!.imageView?.image = UIImage(named: "helpIcon")
<<<<<<< HEAD
<<<<<<< HEAD
			cell!.textLabel?.text = "Actualité"
			break
		case 2:
			cell!.imageView?.image = UIImage(named: "helpIcon")
			cell!.textLabel?.text = "Les Soirées"
			break
		case 3:
=======
			cell!.textLabel?.text = "Les Soirées"
			break
		case 2:
>>>>>>> master
=======
			cell!.textLabel?.text = "Les Soirées"
			break
		case 2:
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
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
<<<<<<< HEAD
<<<<<<< HEAD
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ProfileView") as UIViewController
			break
		case 1:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NewsFeedView") as UIViewController
			break
		case 2:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NightsView") as UIViewController
			break
		case 3:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MyNightsView") as UIViewController
			break		default:
			destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("AgendaView") as UIViewController
=======
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
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
<<<<<<< HEAD
>>>>>>> master
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
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
