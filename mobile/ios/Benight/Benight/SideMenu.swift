//
//  SideMenu.swift
//  SwiftSideMenu
//
//  Created by Kévin VACQUIER on 18/11/2014.
//  Copyright (c) 2014 Benight. All rights reserved.
//

import UIKit

@objc public protocol SideMenuDelegate {
    optional func sideMenuWillOpen()
    optional func sideMenuWillClose()
}

@objc public protocol SideMenuProtocol {
    var sideMenu : SideMenu? { get }
    func setContentViewController(contentViewController: UIViewController)
}

public enum SideMenuAnimation : Int {
    case None
    case Default
}

public enum SideMenuPosition : Int {
    case Left
    case Right
}

public extension UIViewController {
    
    public func toggleSideMenuView () {
        sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    public func hideSideMenuView () {
        sideMenuController()?.sideMenu?.hideSideMenu()
    }
    
    public func showSideMenuView () {
        
        sideMenuController()?.sideMenu?.showSideMenu()
    }
    
    internal func sideMenuController () -> SideMenuProtocol? {
        var iteration : UIViewController? = self.parentViewController
        if (iteration == nil) {
            return topMostController()
        }
        do {
            if (iteration is SideMenuProtocol) {
                return iteration as? SideMenuProtocol
            } else if (iteration?.parentViewController != nil && iteration?.parentViewController != iteration) {
                iteration = iteration!.parentViewController;
            } else {
                iteration = nil;
            }
        } while (iteration != nil)
        
        return iteration as? SideMenuProtocol
    }
    
    internal func topMostController () -> SideMenuProtocol? {
        var topController : UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController
        while (topController?.presentedViewController is SideMenuProtocol) {
            topController = topController?.presentedViewController;
        }
        
        return topController as? SideMenuProtocol
    }
}

public class SideMenu : NSObject {
<<<<<<< HEAD
    
=======
	private(set) var deferred : ()->() = { }

>>>>>>> master
    public var menuWidth : CGFloat = 160.0 {
        didSet {
            needUpdateApperance = true
            updateFrame()
        }
    }
<<<<<<< HEAD
    private let menuPosition:SideMenuPosition = .Left
=======
    private var menuPosition: SideMenuPosition = .Left
>>>>>>> master
    public var bouncingEnabled :Bool = true
    private let sideMenuContainerView =  UIView()
    private var menuTableViewController : UITableViewController!
    private var animator : UIDynamicAnimator!
    private let sourceView : UIView!
    private var needUpdateApperance : Bool = false
    public weak var delegate : SideMenuDelegate?
    private var isMenuOpen : Bool = false
    
<<<<<<< HEAD
    public init(sourceView: UIView, menuPosition: SideMenuPosition) {
        super.init()
        self.sourceView = sourceView
=======
    public init(sourceView: UIView, menuPosition: SideMenuPosition)
	{
        self.sourceView = sourceView
		super.init()
>>>>>>> master
        self.menuPosition = menuPosition
        self.setupMenuView()
    
        animator = UIDynamicAnimator(referenceView:sourceView)
        
        // Add right swipe gesture recognizer
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleGesture:")
        rightSwipeGestureRecognizer.direction =  UISwipeGestureRecognizerDirection.Right
        sourceView.addGestureRecognizer(rightSwipeGestureRecognizer)
        
        // Add left swipe gesture recognizer
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleGesture:")
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        
        if (menuPosition == .Left) {
            sourceView.addGestureRecognizer(rightSwipeGestureRecognizer)
            sideMenuContainerView.addGestureRecognizer(leftSwipeGestureRecognizer)
        }
        else {
            sideMenuContainerView.addGestureRecognizer(rightSwipeGestureRecognizer)
            sourceView.addGestureRecognizer(leftSwipeGestureRecognizer)
        }
        
    }

    public convenience init(sourceView: UIView, menuTableViewController: UITableViewController, menuPosition: SideMenuPosition) {
        self.init(sourceView: sourceView, menuPosition: menuPosition)
        self.menuTableViewController = menuTableViewController
<<<<<<< HEAD
		self.menuTableViewController.tableView.backgroundView = UIImageView(image:UIImage(named:"SideMenuBackground"))
=======
//		self.menuTableViewController.tableView.backgroundView = UIImageView(image:UIImage(named:"SideMenuBackground"))
>>>>>>> master
		self.menuTableViewController.tableView.frame = sideMenuContainerView.bounds
        self.menuTableViewController.tableView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        sideMenuContainerView.addSubview(self.menuTableViewController.tableView)
    }
    
    private func updateFrame() {
        let menuFrame = CGRectMake(
            (menuPosition == .Left) ?
                isMenuOpen ? 0 : -menuWidth-1.0 :
                isMenuOpen ? sourceView.frame.size.width - menuWidth : sourceView.frame.size.width+1.0,
            sourceView.frame.origin.y,
            menuWidth,
            sourceView.frame.size.height
        )
        
        sideMenuContainerView.frame = menuFrame
    }

    private func setupMenuView() {
        
        // Configure side menu container
        updateFrame()

        sideMenuContainerView.clipsToBounds = false
        sideMenuContainerView.layer.masksToBounds = false;
        sideMenuContainerView.layer.shadowOffset = (menuPosition == .Left) ? CGSizeMake(1.0, 1.0) : CGSizeMake(-1.0, -1.0);
        sideMenuContainerView.layer.shadowRadius = 1.0;
        sideMenuContainerView.layer.shadowOpacity = 0.125;
        sideMenuContainerView.layer.shadowPath = UIBezierPath(rect: sideMenuContainerView.bounds).CGPath
        
        sourceView.addSubview(sideMenuContainerView)
        
        if (NSClassFromString("UIVisualEffectView") != nil) {
            // Add blur view
            var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
            visualEffectView.frame = sideMenuContainerView.bounds
            visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
            sideMenuContainerView.addSubview(visualEffectView)
        }
        else {
            // TODO: add blur for ios 7
        }
    }
    
    private func toggleMenu (shouldOpen: Bool) {
        updateSideMenuApperanceIfNeeded()
        isMenuOpen = shouldOpen
        if (bouncingEnabled) {
            
            animator.removeAllBehaviors()
            
            var gravityDirectionX: CGFloat
            var pushMagnitude: CGFloat
            var boundaryPointX: CGFloat
            var boundaryPointY: CGFloat
            
            if (menuPosition == .Left) {
                // Left side menu
                gravityDirectionX = (shouldOpen) ? 1 : -1
                pushMagnitude = (shouldOpen) ? 20 : -20
                boundaryPointX = (shouldOpen) ? menuWidth : -menuWidth-2
                boundaryPointY = 20
            }
            else {
                // Right side menu
                gravityDirectionX = (shouldOpen) ? -1 : 1
                pushMagnitude = (shouldOpen) ? -20 : 20
                boundaryPointX = (shouldOpen) ? sourceView.frame.size.width-menuWidth : sourceView.frame.size.width+menuWidth+2
                boundaryPointY =  -20
            }
            
            let gravityBehavior = UIGravityBehavior(items: [sideMenuContainerView])
            gravityBehavior.gravityDirection = CGVectorMake(gravityDirectionX,  0)
            animator.addBehavior(gravityBehavior)
            
            let collisionBehavior = UICollisionBehavior(items: [sideMenuContainerView])
            collisionBehavior.addBoundaryWithIdentifier("menuBoundary", fromPoint: CGPointMake(boundaryPointX, boundaryPointY),
                toPoint: CGPointMake(boundaryPointX, sourceView.frame.size.height))
            animator.addBehavior(collisionBehavior)
            
            let pushBehavior = UIPushBehavior(items: [sideMenuContainerView], mode: UIPushBehaviorMode.Instantaneous)
            pushBehavior.magnitude = pushMagnitude
            animator.addBehavior(pushBehavior)
            
            let menuViewBehavior = UIDynamicItemBehavior(items: [sideMenuContainerView])
            menuViewBehavior.elasticity = 0.25
            animator.addBehavior(menuViewBehavior)
            
        }
        else {
            var destFrame :CGRect
            if (menuPosition == .Left) {
                destFrame = CGRectMake((shouldOpen) ? -2.0 : -menuWidth, 0, menuWidth, sideMenuContainerView.frame.size.height)
            }
            else {
                destFrame = CGRectMake((shouldOpen) ? sourceView.frame.size.width-menuWidth : sourceView.frame.size.width+2.0,
                                        0,
                                        menuWidth,
                                        sideMenuContainerView.frame.size.height)
            }
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.sideMenuContainerView.frame = destFrame
            })
        }
        
        if (shouldOpen) {
            delegate?.sideMenuWillOpen?()
        } else {
            delegate?.sideMenuWillClose?()
        }
    }
    
    internal func handleGesture(gesture: UISwipeGestureRecognizer) {
        toggleMenu((self.menuPosition == .Right && gesture.direction == .Left)
                || (self.menuPosition == .Left && gesture.direction == .Right))
    }
    
    private func updateSideMenuApperanceIfNeeded () {
        if (needUpdateApperance) {
            var frame = sideMenuContainerView.frame
            frame.size.width = menuWidth
            sideMenuContainerView.frame = frame
            sideMenuContainerView.layer.shadowPath = UIBezierPath(rect: sideMenuContainerView.bounds).CGPath

            needUpdateApperance = false
        }
    }
    
    public func toggleMenu () {
        if (isMenuOpen) {
            toggleMenu(false)
        }
        else {
            updateSideMenuApperanceIfNeeded()
            toggleMenu(true)
        }
    }
    
    public func showSideMenu () {
        if (!isMenuOpen) {
            toggleMenu(true)
        }
    }
    
    public func hideSideMenu () {
        if (isMenuOpen) {
            toggleMenu(false)
        }
    }
}
