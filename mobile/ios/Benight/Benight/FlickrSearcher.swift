//
//  FlickrSearcher.swift
//  Benight
//
//  Created by Kévin VACQUIER on 27/04/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import Foundation
import UIKit
import Parse

let apiKey = "d95c2f660e276021fac7f4448a22288b"

struct FlickrSearchResults {
    let album : PFObject
    let searchResults : [FlickrPhoto]
}

class FlickrPhoto : Equatable {
    var thumbnail : UIImage?
    var largeImage : UIImage?
    let photoID : String
    let farm : Int
    let server : String
    let secret : String
    
    init (photoID:String,farm:Int, server:String, secret:String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    func flickrImageURL(size:String = "m") -> NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")!
    }
    
    func loadLargeImage(completion: (flickrPhoto:FlickrPhoto, error: NSError?) -> Void) {
        let loadURL = flickrImageURL("b")
        let loadRequest = NSURLRequest(URL:loadURL)
        NSURLConnection.sendAsynchronousRequest(loadRequest,
            queue: NSOperationQueue.mainQueue()) {
                response, data, error in
                
                if error != nil {
                    completion(flickrPhoto: self, error: error)
                    return
                }
                
                if data != nil {
                    let returnedImage = UIImage(data: data!)
                    self.largeImage = returnedImage
                    completion(flickrPhoto: self, error: nil)
                    return
                }
                
                completion(flickrPhoto: self, error: nil)
        }
    }
    
    func sizeToFillWidthOfSize(size:CGSize) -> CGSize {
        if thumbnail == nil {
            return size
        }
        
        let imageSize = thumbnail!.size
        var returnSize = size
        
        let aspectRatio = imageSize.width / imageSize.height
        
        returnSize.height = returnSize.width / aspectRatio
        
        if returnSize.height > size.height {
            returnSize.height = size.height
            returnSize.width = size.height * aspectRatio
        }
        
        return returnSize
    }
    
}

func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
    return lhs.photoID == rhs.photoID
}

class Flickr {
    
    let processingQueue = NSOperationQueue()
    
    func searchFlickrForTerm(album:PFObject, completion : (results: FlickrSearchResults?, error : NSError?) -> Void){
        
        let searchURL = flickrSearchURLForSearchTerm(album)
        let searchRequest = NSURLRequest(URL: searchURL)
        NSURLConnection.sendAsynchronousRequest(searchRequest, queue: processingQueue) {response, data, error in
            if error != nil {
                completion(results: nil,error: error)
                return
            }
            do {
                let JSONError : NSError? = nil
                let resultsDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
                if JSONError != nil {
                    completion(results: nil, error: JSONError)
                    return
                }
                
                switch (resultsDictionary!["stat"] as! String) {
                case "ok":
                    print("Results processed OK")
                case "fail":
                    let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:resultsDictionary!["message"]!])
                    completion(results: nil, error: APIError)
                    return
                default:
                    let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Uknown API response"])
                    completion(results: nil, error: APIError)
                    return
                }
                
                let photosContainer = resultsDictionary!["photoset"] as! NSDictionary
                let photosReceived = photosContainer["photo"] as! [NSDictionary]
                
                let flickrPhotos : [FlickrPhoto] = photosReceived.map {
                    photoDictionary in
                    
                    let photoID = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let server = photoDictionary["server"] as? String ?? ""
                    let secret = photoDictionary["secret"] as? String ?? ""
                    
                    let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
                    
                    let imageData = NSData(contentsOfURL: flickrPhoto.flickrImageURL())
                    flickrPhoto.thumbnail = UIImage(data: imageData!)
                    
                    return flickrPhoto
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    completion(results:FlickrSearchResults(album: PFObject(className: "PhotoAlbum"), searchResults: flickrPhotos), error: nil)
                })
            }
            catch _
            {}
        }
    }
    
    private func flickrSearchURLForSearchTerm(album:PFObject) -> NSURL {
        let userId = album["FlickrUserId"] as! String
        let albumId = album["FlickrAlbumId"] as! String
        print(userId)
        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=\(apiKey)&photoset_id=\(albumId)&user_id=\(userId)&per_page=50&format=json&nojsoncallback=1"
        return NSURL(string: URLString)!
    }
    
    
}
