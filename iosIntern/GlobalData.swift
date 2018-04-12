//
//  GlobalData.swift
//  iosIntern
//
//  Created by Manolescu Mihai Alexandru on 10/04/2018.
//  Copyright © 2018 ValiTeam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SDWebImage


var DevelopersList = [Developer]()
var rawDataFromDisk = [DeveloperCD]()
var diskData = [Developer]()

typealias DownloadComplete = () -> ()

class Developer
{
    var image = #imageLiteral(resourceName: "trei")
    var name = String()
    var location = String()
    var goldenBadges = Int()
    var silverBadges = Int()
    var bronzeBadges = Int()
    var timeOfTheRequest = Date()
}

    
func fetchDataFromStackOverFlowAPI(for specificURL: String,completed: @escaping DownloadComplete)
{

    Alamofire.request(specificURL).responseJSON
    {
        response in
        let result = response.result
        
        // print(response)
        
        if let dictionary = result.value as? Dictionary<String, AnyObject>
        {
            
            if let list = dictionary["items"] as? [Dictionary<String, AnyObject>]
            {
                print("\n  Entering the tree \n")
                
                for object in list
                {
                    print( object["display_name"]! )
                    
                    let addingDev =  Developer()
                    addingDev.name = object["display_name"]! as! String
                    addingDev.location = object["location"]! as! String
                    addingDev.goldenBadges = object["badge_counts"]!["gold"]! as! Int
                    addingDev.silverBadges = object["badge_counts"]!["silver"]! as! Int
                    addingDev.bronzeBadges = object["badge_counts"]!["bronze"]! as! Int
                    
                    addingDev.timeOfTheRequest = getCurrentDate()
                    
                    if let downloadURL = NSURL(string: (object["profile_image"]! as! String) )
                    {
                        
                        //download image from URL:
                        if let data = NSData(contentsOf: downloadURL as URL)
                        {
                            addingDev.image = UIImage(data: data as Data)!
                        }
                    }
                    
                    DevelopersList.append(addingDev)
                    //save data to Disk
                    saveObject(named: addingDev)
                    

                }
            }
        }
        completed()
                
    }

}
    




