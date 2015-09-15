//
//  RootNavigationViewController.swift
//  SwiftSideMenu
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit

class SideMenuNavigationController: UINavigationController, SideMenuProtocol {
    
    internal var sideMenu : SideMenu?
    internal var sideMenuAnimationType : SideMenuAnimation = .Default
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init( menuTableViewController: UITableViewController, contentViewController: UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        
        if (contentViewController != nil) {
            self.viewControllers = [contentViewController!]
        }

        sideMenu = SideMenu(sourceView: self.view, menuTableViewController: menuTableViewController, menuPosition:.Left)
        view.bringSubviewToFront(navigationBar)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    func setContentViewController(contentViewController: UIViewController) {
        self.sideMenu?.toggleMenu()
        switch sideMenuAnimationType {
        case .None:
            self.viewControllers = [contentViewController]
            break
        default:
            contentViewController.navigationItem.hidesBackButton = true
            self.setViewControllers([contentViewController], animated: true)
            break
        }
        
    }

}
