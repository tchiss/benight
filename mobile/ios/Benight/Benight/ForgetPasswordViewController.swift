//
//  ForgetPasswordViewController.swift
//  Benight
//
//  Created by Kevin VACQUIER on 04/09/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import Parse

class ForgetPasswordViewController: ResponsiveTextFieldViewController {

    @IBOutlet weak var EmailField: UITextField!
    
    @IBAction func PasswordForget(sender: AnyObject) {
        if (EmailField.text!.characters.count < 0)
        {
            ErrorPopup("N'oubliez pas votre Email SVP")
        }
        else
        {
            var error: NSError? = nil
            do {
                try PFUser.requestPasswordResetForEmail(EmailField.text!)
            } catch let error1 as NSError {
                error = error1
            }
            if (error == nil)
            {
                let alertController = UIAlertController(title: "Ok", message: "Email Envoyé", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                presentViewController(alertController, animated: true, completion: {
                    self.performSegueWithIdentifier("ExitPasswd", sender: nil)
                })
            }
            else
            {
                ErrorPopup("Email Invalide")
            }
        }
    }
    
    
    func ErrorPopup(message: String)
    {
        let alertController = UIAlertController(title: "Erreur", message: message, preferredStyle: .Alert)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
