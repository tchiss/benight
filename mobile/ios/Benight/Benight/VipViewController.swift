//
//  VipViewController.swift
//  
//
//  Created by Kevin VACQUIER on 20/01/2016.
//
//

import UIKit
import WebKit

class VipViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var ContainerView: UIView!

    
    var webView: WKWebView?

    
    func webView(webView: WKWebView,
        decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse,
        decisionHandler: ((WKNavigationResponsePolicy) -> Void)){
            
            print(navigationResponse.response.MIMEType)
            
            decisionHandler(.Allow)
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Create our preferences on how the web page should be loaded */
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        /* Create a configuration for our preferences */
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        /* Now instantiate the web view */
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView?.backgroundColor = UIColor.blackColor()
        if let theWebView = webView{
            /* Load a web page into our web view */
            let url = NSURL(string: "http://vip.benight.cc")
            let urlRequest = NSURLRequest(URL: url!)
            theWebView.loadRequest(urlRequest)
            theWebView.navigationDelegate = self
            view.addSubview(theWebView)
            let close = UIImage(named: "cancel")
            let btn: UIButton = UIButton(type: UIButtonType.System)
            btn.frame = CGRectMake(20 , 20, 20, 20)
            btn.setTitle("", forState: UIControlState.Normal)
            btn.setImage(close, forState: .Normal)
            btn.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.tag = 1               // change tag property
            self.view.addSubview(btn)
        }
        
    }
    
    func webView(webView: WKWebView,
        didStartProvisionalNavigation navigation: WKNavigation){
            SwiftSpinner.show("Loading")
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        SwiftSpinner.hide()
    }

    
    func buttonAction(sender: UIButton!) {
        let tmpController :UIViewController! = self.presentingViewController;
        
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            tmpController.dismissViewControllerAnimated(false, completion: nil);
        });
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
