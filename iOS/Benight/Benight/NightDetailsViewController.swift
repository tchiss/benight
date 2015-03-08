//
//  NightDetailsViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 25/02/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit

class NightDetailsViewController: UIViewController {

	var event: PFObject = PFObject(className: "Event")
	
	
	@IBOutlet var switchInsc: UISwitch!
	@IBOutlet var inscLabel: UILabel!
	@IBOutlet var DateLabel: UILabel!
	@IBOutlet var descLabel: UILabel!
	@IBOutlet var nameLabel: UILabel!
	
	
	@IBAction func switchChanger(sender: AnyObject) {
		if (switchInsc.on)
		{
			inscLabel.text = "Inscrit"
			var resa = PFObject(className:"Reservation")
			resa["User"] = PFUser.currentUser()
			resa["Event"] = event
			resa.saveInBackground()
		}
		else
		{
			inscLabel.text = "Non Inscrit"
			print("titi")

		}

	}

    override func viewDidLoad() {
        super.viewDidLoad()
				self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
		nameLabel.text = event["name"] as String!
		//cell.PlaceLabel.text = events[indexPath.row]["location"] as String!
		descLabel.text = event["theme"] as String!
		DateLabel.text = (event["date"] as NSDate!).description
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
