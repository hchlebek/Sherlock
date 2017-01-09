//
//  DetailGuideVC.swift
//  SherlockApp
//
//  Created by HChlebek on 12/13/16.
//  Copyright © 2016 HChlebek. All rights reserved.
//

import UIKit

class DetailGuideVC: UIViewController
{
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTextView: UITextView!

   // Image and summary data segued from ViewController
    var detailImage : String!
    var detailSummary : String!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
     //  Checks that image is downloaded and sets it to myImageView
        if let checkedUrl = URL(string: detailImage) {
            myImageView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }
        
        //  TextView shows the summary converted to plain text
        myTextView.text = detailSummary!.html2String
        
        
    }
    
    // Functions download images from the url
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.myImageView.image = UIImage(data: data)
            }
        }
        
    }
}

// Converts html to plain text
extension String {
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
