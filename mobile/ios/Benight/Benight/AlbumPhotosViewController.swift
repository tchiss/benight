//
//  AlbumPhotosViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 27/04/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit

class AlbumPhotosViewController: UICollectionViewController {
	
    @IBOutlet weak var PageTitle: UINavigationItem!
    
	private let reuseIdentifier = "FlickrCell"
	private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
	private var searches = [FlickrSearchResults]()
	private let flickr = Flickr()
    var isPresent = false
    var album: PFObject = PFObject(className: "PhotoAlbum")
	
    
    override func supportedInterfaceOrientations() -> Int {
            return Int(UIInterfaceOrientationMask.All.rawValue)
    }
	override func viewDidLoad() {
        self.isPresent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "background"),
            forBarMetrics: .Default)
        super.viewDidLoad()
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        SwiftSpinner.show("Getting Pictures...")
        album.fetch()
        self.PageTitle.title = album["title"] as? String

        flickr.searchFlickrForTerm(album) {
			results, error in
			if error != nil {
				println("Error searching : \(error)")
                SwiftSpinner.hide()
            }
			if results != nil {
                self.searches.insert(results!, atIndex: 0)
				self.collectionView?.reloadData()
                SwiftSpinner.hide()
			}
		}
	}

	func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto
	{
		return searches[indexPath.section].searchResults[indexPath.row]
	}
	
}

extension AlbumPhotosViewController : UICollectionViewDataSource {
 
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return searches.count
	}
 
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return searches[section].searchResults.count
	}
 
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
  let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AlbumPhotoCell
  let flickrPhoto = photoForIndexPath(indexPath)
  cell.backgroundColor = UIColor.blackColor()
  cell.imageView.image = flickrPhoto.thumbnail
		
  return cell
	}
}

extension AlbumPhotosViewController : UICollectionViewDelegateFlowLayout {
	func collectionView(collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
			
			let flickrPhoto =  photoForIndexPath(indexPath)
			if var size = flickrPhoto.thumbnail?.size {
				size.width += 5
				size.height += 5
				return size
			}
			return CGSize(width: 100, height: 100)
	}
 
	func collectionView(collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAtIndex section: Int) -> UIEdgeInsets {
			return sectionInsets
	}
}
