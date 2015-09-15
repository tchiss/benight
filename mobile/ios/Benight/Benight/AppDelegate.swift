//
//  AppDelegate.swift
//  Benight
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		Parse.setApplicationId("KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", clientKey:"qayqlys4VkNJDQ06PUUa0aUp8i7g871mjFDmlyCb")
		PFFacebookUtils.initializeFacebook()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.3, blue: 0.5, alpha: 0.0)
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().translucent = true
        return true
	}
	func application(application: UIApplication,
		openURL url: NSURL,
		sourceApplication: String?,
		annotation: AnyObject?) -> Bool {
			return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
				withSession:PFFacebookUtils.session())
	}

	func applicationDidBecomeActive(application: UIApplication) {
		FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
	}
	
	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}
	
	
	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
    
	
}



extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}
