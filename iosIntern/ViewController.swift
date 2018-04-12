//
//  ViewController.swift
//  iosIntern
//
//  Created by Manolescu Mihai Alexandru on 10/04/2018.
//  Copyright © 2018 ValiTeam. All rights reserved.
//

import UIKit
import Alamofire
import CoreData


class FirstScreen: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return DevelopersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        cell.textLabel?.text =  DevelopersList[indexPath.row].name
        cell.imageView?.image = DevelopersList[indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "segueOne", sender: DevelopersList[indexPath.row])
    }
    
    
    @IBOutlet var listWithDevs: UITableView!
    
    override func viewDidAppear(_ animated: Bool)
    {
        print("date: ", getDateAsString(getCurrentDate()) )
        
        print("\n Checking the data from RAM: ")
        //check    data from RAM
        if !DevelopersList.isEmpty
        {
            print("\n Checking if the data from RAM is valid: ")
            let lastLocalAccess = DevelopersList[0].timeOfTheRequest
            
            print("\n\n Last access of local object: ")
            let diff = getDifference(between: lastLocalAccess, and: getCurrentDate())
            
            print("\n\n Last local access: ", diff)
            
            print("\n\n Checking if the data in RAM is expired or not: \n")
            if diff > 600
            {
                print("\n Data in RAM is expired")
                
                checkDisk()
            }
            else
            {
                print("\n Data in RAM is valid")
            }
        }
        else
        {
            print("\n\n There is no data in RAM \n")
            checkDisk()
        }
    }

    override func viewDidLoad()
    {
        
        self.listWithDevs.dataSource = self
        self.listWithDevs.delegate = self
        
        

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func checkDisk()
    {
        fetchListFromDisk()
        
        if rawDataFromDisk.isEmpty
        {
            fetchDataFromStackOverFlowAPI(for: "https://api.stackexchange.com/2.2/users?pagesize=10&order=desc&sort=reputation&site=stackoverflow", completed:
                {
                    print("\n\n  Finished fetching data from API \n")
                    self.listWithDevs.reloadData()
            })
        }
        else
        {
            var diff = Int()
            print(" \n status: printing objects from disk:")
            for object in rawDataFromDisk
            {
                if let time=object.timeOfTheRequest
                {
                    //print(time)
                    
                    diff = getDifference(between: time, and: getCurrentDate())
                    
                }
            }
            
            if(diff>30*60) //30 minutes in seconds
            {
                print("\n\n Data from disk is expired. So call API:")
                
                //data from disk is expired. we have to make a new request and delete the old data from disk:
                deleteRecordsCD()
                
                fetchDataFromStackOverFlowAPI(for: "https://api.stackexchange.com/2.2/users?pagesize=10&order=desc&sort=reputation&site=stackoverflow", completed:
                    {
                        print("\n\n  Finished fetching data from API \n")
                        self.listWithDevs.reloadData()
                })
                
            }
            else
            {
                print("\n\n Data from disk not expired. So we can use it: ")
                DevelopersList.removeAll()
                
                for object in rawDataFromDisk
                {
                    let localObject = Developer()
                    localObject.name = object.name!
                    localObject.location = object.location!
                    localObject.goldenBadges = Int(object.goldBadges)
                    localObject.bronzeBadges = Int(object.bronzeBadges)
                    localObject.silverBadges = Int(object.silverBadges)
                    localObject.image = UIImage(data: object.image as! Data)!
                    
                    DevelopersList.append(localObject)
                }
                
                print("\n\n Fetched data from disk. \n")
            }
        }
        
        
        
        self.listWithDevs.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let VC = segue.destination as! SecondScreen
        VC.currentDeveloper = sender as! Developer

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

