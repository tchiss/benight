//
//  ResponsiveTextFieldViewController.swift
//  Benight
//
//  Created by Kévin VACQUIER on 09/03/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import UIKit
import Foundation


class ResponsiveTextFieldViewController : UIViewController
{

    override func shouldAutorotate() -> Bool {
        return false
    }
    
	var kPreferredTextFieldToKeyboardOffset: CGFloat = 35.0
	var keyboardFrame: CGRect = CGRect.nullRect
	var keyboardIsShowing: Bool = false
	weak var activeTextField: UITextField?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
		
		for subview in self.view.subviews
		{
			if (subview.isKindOfClass(UITextField))
			{
				var textField = subview as! UITextField
				textField.addTarget(self, action: "textFieldDidReturn:", forControlEvents: UIControlEvents.EditingDidEndOnExit)
				
				textField.addTarget(self, action: "textFieldDidBeginEditing:", forControlEvents: UIControlEvents.EditingDidBegin)
				
			}
		}
		
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	
	func keyboardWillShow(notification: NSNotification)
	{
		self.keyboardIsShowing = true
		
		if let info = notification.userInfo {
			self.keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
			self.arrangeViewOffsetFromKeyboard()
		}
		
	}
	
	func keyboardWillHide(notification: NSNotification)
	{
		self.keyboardIsShowing = false
		
		self.returnViewToInitialFrame()
	}
	
	func arrangeViewOffsetFromKeyboard()
	{
		var theApp: UIApplication = UIApplication.sharedApplication()
		var windowView: UIView? = theApp.delegate!.window!
		
		var textFieldLowerPoint: CGPoint = CGPointMake(self.activeTextField!.frame.origin.x, self.activeTextField!.frame.origin.y + self.activeTextField!.frame.size.height)
		
		var convertedTextFieldLowerPoint: CGPoint = self.view.convertPoint(textFieldLowerPoint, toView: windowView)
		
		var targetTextFieldLowerPoint: CGPoint = CGPointMake(self.activeTextField!.frame.origin.x, self.keyboardFrame.origin.y - kPreferredTextFieldToKeyboardOffset)
		
		var targetPointOffset: CGFloat = targetTextFieldLowerPoint.y - convertedTextFieldLowerPoint.y
		if (targetPointOffset > 0){
			targetPointOffset = 0
		}
		var adjustedViewFrameCenter: CGPoint = CGPointMake(self.view.center.x, self.view.center.y + targetPointOffset)
		
		UIView.animateWithDuration(0.5, animations:  {
			self.view.center = adjustedViewFrameCenter
		})
	}
	
	func returnViewToInitialFrame()
	{
		var initialViewRect: CGRect = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)
		
		if (!CGRectEqualToRect(initialViewRect, self.view.frame))
		{
			UIView.animateWithDuration(0.2, animations: {
				self.view.frame = initialViewRect
			});
		}
	}
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
	{
		if (self.activeTextField != nil)
		{
			self.activeTextField?.resignFirstResponder()
			self.activeTextField = nil
		}
	}
	
	@IBAction func textFieldDidReturn(textField: UITextField!)
	{
		textField.resignFirstResponder()
		self.activeTextField = nil
	}
	
	func textFieldDidBeginEditing(textField: UITextField)
	{
		self.activeTextField = textField
		
		if(self.keyboardIsShowing)
		{
			self.arrangeViewOffsetFromKeyboard()
		}
	}
}
