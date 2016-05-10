//
//  GlobalVariable.swift
//  Benight
//
//  Created by Kevin VACQUIER on 26/11/2015.
//  Copyright © 2015 Benight. All rights reserved.
//

import Foundation
import Parse

class GlobalVariables {
    
    // These are the properties you can store in your singleton
    internal var userLoc: PFGeoPoint? = nil
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}