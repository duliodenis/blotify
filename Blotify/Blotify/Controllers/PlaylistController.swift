//
//  PlaylistController.swift
//  Blotify
//
//  Created by Dulio Denis on 2/24/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit
import Alamofire

class PlaylistController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var searchURL = "https://api.spotify.com/v1/search?q=tania%20bowra&type=artist"
    typealias StandardJSON = [String:AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSpotifyCatalogWith(url: searchURL)
    }
    
    func getSpotifyCatalogWith(url: String) {
        Alamofire.request(url).responseJSON { (response) in
            self.parseData(JSONData: response.data!)
        }
    }
    
    func parseData(JSONData: Data) {
        do {
            var parsedJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as? StandardJSON
            print(parsedJSON)
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
    }
    
}
