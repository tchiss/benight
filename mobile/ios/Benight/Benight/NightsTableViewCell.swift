//
//  NightsTableViewCell.swift
//  Benight
//
//  Created by Kévin VACQUIER on 28/01/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import QuartzCore
import Parse

class NightsTableViewCell: UITableViewCell {

	@IBOutlet var mainView: UIView!
	@IBOutlet var NameLabel: UILabel!
	@IBOutlet var PlaceLabel: UILabel!
	@IBOutlet var DateLabel: UILabel!
	@IBOutlet var ThemeLabel: UILabel!
    @IBOutlet weak var FlyerImage: UIImageView!
    @IBOutlet weak var SoldOutImage: UIImageView!

	func fillCell(event: PFObject)
	{
		self.NameLabel.text = event["name"] as? String
		self.PlaceLabel.text = event["author"] as? String
        self.ThemeLabel.text = event["theme"] as? String
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = .MediumStyle
        formatter.locale = NSLocale(localeIdentifier: "fr_FR")
        
        DateLabel.text = formatter.stringFromDate(event["date"] as! NSDate!)
        if (event["PlaceLeft"] as! NSNumber != 0)
        {
            SoldOutImage.hidden = true
        }
        if let vipleft = event["PlaceVipLeft"] as? NSNumber
        {
            if vipleft != 0
            {
                SoldOutImage.hidden = true
            }
        }
        if (event["Flyer"] != nil)
        {
            if let userImageFile = event["Flyer"] as? PFFile
            {
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.FlyerImage.image = image
                    }
                }
            }
        }
        }

	}
}
