//
//  SecondScreen.swift
//  iosIntern
//
//  Created by Manolescu Mihai Alexandru on 10/04/2018.
//  Copyright © 2018 ValiTeam. All rights reserved.
//

import UIKit
import Foundation

class SecondScreen: UIViewController
{

    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var location: UILabel!
    
    @IBOutlet var goldBadges: UILabel!
    
    @IBOutlet var silverBadges: UILabel!
    
    @IBOutlet var bronzeBadges: UILabel!
    
    
    var currentDeveloper = Developer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        profileImage.image = currentDeveloper.image
        name.text = currentDeveloper.name
        location.text = "Location: " + currentDeveloper.location
        goldBadges.text = "Gold Badges: " + String(currentDeveloper.goldenBadges)
        silverBadges.text = "Silver Badges: " + String(currentDeveloper.silverBadges)
        bronzeBadges.text = "Bronze Badges: " + String(currentDeveloper.bronzeBadges)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
