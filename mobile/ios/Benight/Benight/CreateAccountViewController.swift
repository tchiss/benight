//
//  CreateAccountViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 20/02/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import Parse

class CreateAccountViewController: ResponsiveTextFieldViewController {
	
	@IBOutlet var passwordField: UITextField!
	@IBOutlet var loginField: UITextField!
	@IBOutlet var emailField: UITextField!
	@IBOutlet var confirmField: UITextField!
	@IBOutlet var nameField: UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
				self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		// Do any additional setup after loading the view.
		let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
    override func shouldAutorotate() -> Bool {
        return false
    }
    
	func ErrorPopup(message: String)
	{
		let alertController = UIAlertController(title: "Erreur", message: message, preferredStyle: .Alert)
		
		let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	func NicePopup(message: String)
	{
		let alertController = UIAlertController(title: "Bonjour", message: message, preferredStyle: .Alert)
		
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { (actionSheetController) -> Void in
            self.dismissViewControllerAnimated(true, completion: {});
        })
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
	
	func createAccount()
    {
		if (passwordField.text == confirmField.text)
		{
		let user = PFUser()
		user.username = loginField.text
		user.password = passwordField.text
		user.email = emailField.text
		user["name"] = nameField.text
		
		user.signUpInBackgroundWithBlock {
			(succeeded: Bool, error1: NSError?) -> Void in
			if error1 == nil {
				self.NicePopup("Votre compte à été créé")
				self.performSegueWithIdentifier("accountCreated", sender: nil)
			} else {
				let errorString = error1!.userInfo["error"] as! NSString
				self.ErrorPopup(errorString as String)
			}
		}
		}
		else
		{
			self.ErrorPopup("Erreur de vérification de mot de passe")
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
