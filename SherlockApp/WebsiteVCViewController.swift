//
//  WebsiteVCViewController.swift
//  SherlockApp
//
//  Created by HChlebek on 12/15/16.
//  Copyright © 2016 HChlebek. All rights reserved.
//

import SafariServices

class WebsiteVCViewController: UIViewController, SFSafariViewControllerDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
    }

    @IBAction func WebButtonPressed(_ sender: UIButton)
    {
        // sets URL
    let myURL = NSURL(string: "http://www.sherlockology.com")
        let svc = SFSafariViewController(url: myURL! as URL)
        svc.delegate = self
        // Presents website
        present(svc, animated: true, completion: nil)
    }
    // dismisses ViewController
    func safariViewControllerDidFinish(controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
        
    }
   
    
    


}
