//
//  CreateAccountViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 20/02/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
	
	@IBOutlet var passwordField: UITextField!
	@IBOutlet var loginField: UITextField!
	@IBOutlet var emailField: UITextField!
	@IBOutlet var confirmField: UITextField!
	@IBOutlet var nameField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
				self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		// Do any additional setup after loading the view.
		var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	func ErrorPopup(message: String)
	{
		let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
		
		let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	func NicePopup(message: String)
	{
		let alertController = UIAlertController(title: "Hi :)", message: message, preferredStyle: .Alert)
		
		let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func DismissKeyboard(){
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}
	
	@IBAction func CreateAcount(sender: AnyObject) {
		createAccount()
	}
	
	func createAccount() {
		if (passwordField.text == confirmField.text)
		{
		var user = PFUser()
		user.username = loginField.text
		user.password = passwordField.text
		user.email = emailField.text
		user["name"] = nameField.text
		
		user.signUpInBackgroundWithBlock {
			(succeeded: Bool!, error1: NSError!) -> Void in
			if error1 == nil {
				self.NicePopup("Your account is created, Welcome")
				self.performSegueWithIdentifier("accountCreated", sender: nil)
			} else {
				let errorString = error1.userInfo!["error"] as NSString
				self.ErrorPopup(errorString)}
		}
		}
		else
		{
			self.ErrorPopup("Please put same password")
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
