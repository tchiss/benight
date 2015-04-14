//
//  EditProfileTableViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 15/04/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit

class EditProfileTableViewController: UITableViewController {
		@IBOutlet var ProfileImage: UIImageView!
		
		@IBOutlet var Statut: UILabel!
		@IBOutlet var UserName: UILabel!
		@IBOutlet var UserPhone: UITextField!
		@IBOutlet var UserEmail: UITextField!
		@IBOutlet var UserWeb: UITextField!
		
		
		@IBOutlet var UserAdress: UITextField!
		override func viewDidLoad() {
			super.viewDidLoad()
			self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
			var user = PFUser.currentUser()
			self.ProfileImage.layer.cornerRadius = self.ProfileImage.frame.size.width / 2
			self.ProfileImage.clipsToBounds = true
			UserName.text = PFUser.currentUser().username
			UserEmail.text = PFUser.currentUser().email
			if (user["phone"] != nil){
				UserPhone.text = user["phone"] as NSString}
			else{
				UserPhone.text = "Unknow"}
			
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
			return 5
		}
}
