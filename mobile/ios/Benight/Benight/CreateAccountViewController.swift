//
//  CreateAccountViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 20/02/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit

class CreateAccountViewController: ResponsiveTextFieldViewController {
	
	@IBOutlet var passwordField: UITextField!
	@IBOutlet var loginField: UITextField!
	@IBOutlet var emailField: UITextField!
	@IBOutlet var confirmField: UITextField!
	@IBOutlet var nameField: UITextField!
	
	
<<<<<<< HEAD
<<<<<<< HEAD
	
=======
>>>>>>> master
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
	override func viewDidLoad() {
		super.viewDidLoad()
				self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		// Do any additional setup after loading the view.
		var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
    override func shouldAutorotate() -> Bool {
        return false
    }
    
<<<<<<< HEAD
>>>>>>> master
=======
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
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
	
<<<<<<< HEAD
<<<<<<< HEAD
	func createAccount() {
=======
	func createAccount()
    {
>>>>>>> master
=======
	func createAccount()
    {
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
		if (passwordField.text == confirmField.text)
		{
		var user = PFUser()
		user.username = loginField.text
		user.password = passwordField.text
		user.email = emailField.text
		user["name"] = nameField.text
		
		user.signUpInBackgroundWithBlock {
<<<<<<< HEAD
<<<<<<< HEAD
			(succeeded: Bool!, error1: NSError!) -> Void in
=======
			(succeeded: Bool, error1: NSError?) -> Void in
>>>>>>> master
=======
			(succeeded: Bool, error1: NSError?) -> Void in
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
			if error1 == nil {
				self.NicePopup("Your account is created, Welcome")
				self.performSegueWithIdentifier("accountCreated", sender: nil)
			} else {
<<<<<<< HEAD
<<<<<<< HEAD
				let errorString = error1.userInfo!["error"] as NSString
				self.ErrorPopup(errorString)}
=======
				let errorString = error1!.userInfo!["error"] as! NSString
				self.ErrorPopup(errorString as String)
			}
>>>>>>> master
=======
				let errorString = error1!.userInfo!["error"] as! NSString
				self.ErrorPopup(errorString as String)
			}
>>>>>>> 0c94aa5349038aa570b1a5831ce89db810edfbfd
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
