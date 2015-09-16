//
//  NightMapViewController.swift
//  Benight
//
//  Created by Kevin VACQUIER on 16/09/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import MapKit

class NightMapViewController: UIViewController {
    @IBOutlet weak var Tital: UINavigationItem!
    var descLocation: PFGeoPoint = PFGeoPoint()
    var placeTitle: String = ""
    var eventTitle: String = ""

    @IBOutlet var map: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000

    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
        println(location)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let status = CLLocationManager.authorizationStatus()
        var latitude: CLLocationDegrees = descLocation.latitude
        var longtitude: CLLocationDegrees = descLocation.longitude
        var location: CLLocation = CLLocation(latitude: latitude, longitude: longtitude)
        var loc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        centerMapOnLocation(location)
        var annotation = MKPointAnnotation()
        annotation.title = placeTitle
        annotation.coordinate = loc
        
        map.addAnnotation(annotation)
        Tital.title = eventTitle
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
