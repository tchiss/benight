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
<<<<<<< HEAD
		@IBOutlet var UserName: UILabel!
		@IBOutlet var UserPhone: UITextField!
		@IBOutlet var UserEmail: UITextField!
		@IBOutlet var UserWeb: UITextField!
		
		
		@IBOutlet var UserAdress: UITextField!
		override func viewDidLoad() {
=======
		@IBOutlet var UserName: UITextField!
		@IBOutlet var UserPhone: UITextField!
		@IBOutlet var UserEmail: UITextField!
		@IBOutlet var UserWeb: UITextField!
		@IBOutlet var UserPasswd: UITextField!
		@IBOutlet var ConfirmPasswd: UITextField!
		@IBOutlet var UserAdress: UITextField!
	
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
>>>>>>> master
			super.viewDidLoad()
			self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
			var user = PFUser.currentUser()
			self.ProfileImage.layer.cornerRadius = self.ProfileImage.frame.size.width / 2
			self.ProfileImage.clipsToBounds = true
<<<<<<< HEAD
			UserName.text = PFUser.currentUser().username
			UserEmail.text = PFUser.currentUser().email
			if (user["phone"] != nil){
				UserPhone.text = user["phone"] as NSString}
			else{
				UserPhone.text = "Unknow"}
=======
			UserName.text = user!.username
			UserEmail.text = user!.email
			UserPhone.text = PFUser.currentUser()!["phone"] as? String ?? "Unknown"
			UserAdress.text = PFUser.currentUser()!["adress"] as? String ?? "Unknown"
>>>>>>> master
			
			// Uncomment the following line to preserve selection between presentations
			// self.clearsSelectionOnViewWillAppear = false
			
			// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
			// self.navigationItem.rightBarButtonItem = self.editButtonItem()
		}
<<<<<<< HEAD
		
		override func didReceiveMemoryWarning() {
=======
	func ErrorPopup(message: String)
	{
		let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
		
		let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	
	func SavePopup(message: String)
	{
		let alertController = UIAlertController(title: "Saved", message: message, preferredStyle: .Alert)
		
		let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	
	@IBAction func Save(sender: AnyObject) {
		var user = PFUser.currentUser()
		if (UserPasswd.text == ConfirmPasswd.text)
		{
			user!.email = UserEmail.text
			user!.username = UserName.text
			user!.password = UserPasswd.text
			user!.saveInBackgroundWithBlock(
			{
				(success: Bool, error: NSError?) -> Void in
				if (success) {
					self.SavePopup("Informations saved")
				} else {
					self.ErrorPopup(error!.userInfo!.description)
				}
			})
		}
		else {
			print("toto")
		}
	}
	
	override func didReceiveMemoryWarning() {
>>>>>>> master
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
<<<<<<< HEAD
			return 5
=======
			return 7
>>>>>>> master
		}
}