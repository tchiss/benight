//
//  NightsTableViewCell.swift
//  Benight
//
//  Created by Kévin VACQUIER on 28/01/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import QuartzCore

class NightsTableViewCell: UITableViewCell {

	@IBOutlet var mainView: UIView!
	@IBOutlet var NameLabel: UILabel!
	@IBOutlet var PlaceLabel: UILabel!
	@IBOutlet var DateLabel: UILabel!
	@IBOutlet var ThemeLabel: UILabel!

	func fillCell(event: AnyObject)
	{
<<<<<<< HEAD
		self.mainView.layer.cornerRadius = 10
		self.mainView.layer.masksToBounds = true
		self.NameLabel.text = event["name"] as String!
		//cell.PlaceLabel.text = events[indexPath.row]["location"] as String!
		self.ThemeLabel.text = event["theme"] as String!
		self.DateLabel.text = (event["date"] as NSDate!).description
=======
		self.NameLabel.text = event["name"] as? String
		self.PlaceLabel.text = event["author"] as? String
        self.ThemeLabel.text = event["theme"] as? String
		self.DateLabel.text = (event["date"] as! NSDate!).description
>>>>>>> master
	}
}