//
//  ImageFullViewController.swift
//  Benight
//
//  Created by Kevin VACQUIER on 12/11/2015.
//  Copyright © 2015 Benight. All rights reserved.
//

import UIKit

class ImageFullViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    var bigPhoto: FlickrPhoto? = nil
    var photo: FlickrPhoto? = nil
    var asBig: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        photo?.loadLargeImage{
            (succeeded: FlickrPhoto, error1: NSError?) -> Void in
            self.ImageView.image = succeeded.largeImage
            self.bigPhoto = succeeded
            self.asBig = true
        }
        print(photo!)
        ImageView.image = photo?.thumbnail
    }

    @IBAction func Share(sender: AnyObject) {
        if asBig
        {
        let vc = UIActivityViewController(activityItems: [(bigPhoto?.largeImage)!], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
        }
        else
        {
        let vc = UIActivityViewController(activityItems: [(photo?.thumbnail)!], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
        }
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
