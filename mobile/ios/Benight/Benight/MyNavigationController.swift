//
//  MyNavigationController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit

extension UINavigationController {
   // public override func supportedInterfaceOrientations() -> Int {
    //    return visibleViewController.supportedInterfaceOrientations()
    //}
    public override func shouldAutorotate() -> Bool {
       return visibleViewController!.shouldAutorotate()
    }
}

class MyNavigationController: SideMenuNavigationController, SideMenuDelegate {
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sideMenu = SideMenu(sourceView: self.view, menuTableViewController: MyMenuTableViewController(), menuPosition:.Left)
		sideMenu?.delegate = self
		sideMenu?.menuWidth = 200.0
		view.bringSubviewToFront(navigationBar)
		// make navigation bar showing over side menu
		//view.bringSubviewToFront(navigationBar)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - SideMenu Delegate
	func sideMenuWillOpen() {
	}
	
	func sideMenuWillClose() {
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
