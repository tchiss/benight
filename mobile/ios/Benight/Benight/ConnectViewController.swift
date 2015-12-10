	//
//  ViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

    import UIKit
    import Parse
    import Bolts
    import ParseFacebookUtilsV4
    import FBSDKCoreKit
    import FBSDKLoginKit

class ConnectViewController: ResponsiveTextFieldViewController {
	@IBOutlet var emailField: UITextField!
	@IBOutlet var passwdField: UITextField!
	
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func ErrorPopup(message: String)
    {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
	{
		super.viewDidLoad()
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		// Do any additional setup after loading the view.
		let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,	action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func DismissKeyboard(){
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}
	
	@IBAction func ConnectUser(sender: UIButton)
	{
		
		if (emailField.text!.characters.count > 0)
		{
			if (passwdField.text!.characters.count > 0)
			{
                SwiftSpinner.show("Connection...")
				PFUser.logInWithUsernameInBackground(emailField.text!, password: passwdField.text!) {
					(user: PFUser?, error: NSError?) -> Void in
					if user != nil {
						print("login ok", terminator: "")
                        SwiftSpinner.hide()
						self.performSegueWithIdentifier("Connected", sender: nil)
					} else {
						self.ErrorPopup("Login Failed")}
                    SwiftSpinner.hide()
				}
			}
			else {
				ErrorPopup("Please Enter an Email")}
			
		}
		else {
			ErrorPopup("Please Enter an Email")}
	}
	
	@IBAction func ConnectWithFace(sender: AnyObject)
	{
        //SwiftSpinner.show("Connection...")
		let permissions = ["user_about_me", "user_relationships", "user_birthday", "user_location"]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
				if user == nil
				{
                    SwiftSpinner.hide()
					NSLog("Uh oh. The user cancelled the Facebook login.")
				}
				else if user!.isNew
				{
                    SwiftSpinner.hide()
                    self.performSegueWithIdentifier("Connected", sender: nil)
				}
				else
				{
                    SwiftSpinner.hide()
                    self.performSegueWithIdentifier("Connected", sender: nil)
				}
		}
	}
}


