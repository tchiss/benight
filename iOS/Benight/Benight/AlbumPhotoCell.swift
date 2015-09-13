//
//  AlbumPhotoCell.swift
//  Benight
//
//  Created by Kévin VACQUIER on 27/04/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit

class AlbumPhotoCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	override func awakeFromNib() {
  super.awakeFromNib()
  self.selected = false
	}
 
	override var selected : Bool {
  didSet {
	self.backgroundColor = UIColor.blackColor()
  }
	}

}
