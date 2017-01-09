//
//  ViewController.swift
//  SherlockApp
//
//  Created by HChlebek on 12/7/16.
//  Copyright © 2016 HChlebek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
    
{
    @IBOutlet weak var myTableView: UITableView!
    
    //initializing empty array of dictionaries
    var episodes = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let URLString = "http://api.tvmaze.com/shows/335/episodes"
        //if statement check to see if URL is valid
        if let url = NSURL(string: URLString)
        {
            //returns data from object URL. Try checks for URL connections
            if let myData = try? NSData(contentsOf: url as URL, options: []) {
                //if data object was created successfully, we create  swift json structure
                let json = JSON(data: myData as Data)
                print ("good")
                parse(json: json)
            }
        }
        
    }
    //reads the results array from api
    func parse(json: JSON) {
        for result in json[].arrayValue {
            //grabbing values from keys
            let name = result["name"].stringValue
            let season = result["season"].stringValue
            let number = result["number"].stringValue
            let summary = result["summary"].stringValue
            let picture = result["image"]["original"].stringValue
            
            //creates a dictionary with keys and values
            let object = ["name" : name, "season": season, "number": number, "summary" : summary, "image" : picture]
            // places it in array
            episodes.append(object)
            
        }
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        //sets the title and info text in the cell
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode["name"]
        cell.detailTextLabel?.text = "Season: \(episode["season"]!)  Episode: \(episode["number"]!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return episodes.count
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = myTableView.indexPathForSelectedRow
        {
            let episode = episodes[indexPath.row]
            let nextController = segue.destination as! DetailGuideVC
            
            
            nextController.detailImage = episode["image"]!
            nextController.detailSummary = episode["summary"]!
        }

    }
    
    


}

