//
//  SendMailViewController.swift
//  Benight
//
//  Created by Kevin VACQUIER on 08/05/2016.
//  Copyright © 2016 Benight. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


class SendMailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
        @IBAction func sendEmailButtonTapped(sender: AnyObject) {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
    
        func configuredMailComposeViewController() -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
            
            mailComposerVC.setToRecipients(["benight_2016@labeip.epitech.eu "])
            mailComposerVC.setSubject("Question à propos de Benight iOS")
            mailComposerVC.setMessageBody("Inscrivez ici votre question :", isHTML: false)
            
            return mailComposerVC
        }
        
        func showSendMailErrorAlert() {
            let sendMailErrorAlert = UIAlertView(title: "Erreur d'email", message: "Votre appareil est mal configuré quant à l'envoi d'email. Verifiez votre configuration et essayez à nouveau.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
        // MARK: MFMailComposeViewControllerDelegate
        
        func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
}
