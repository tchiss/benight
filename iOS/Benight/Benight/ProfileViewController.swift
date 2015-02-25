//
//  ProfileViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 17/12/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	@IBAction func Logout(sender: AnyObject) {
		PFUser.logOut();
		performSegueWithIdentifier("Logout", sender: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
