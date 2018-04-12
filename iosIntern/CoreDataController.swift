//
//  CoreDataController.swift
//  iosIntern
//
//  Created by Manolescu Mihai Alexandru on 12/04/2018.
//  Copyright © 2018 ValiTeam. All rights reserved.
//

import UIKit
import Foundation
import CoreData

func saveObject(named developer: Developer)
{
    //context for coredata
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //the developer's data that we are currently presistently saving:
    let entity = NSEntityDescription.insertNewObject(forEntityName: "DeveloperCD", into: context) as! DeveloperCD
    entity.name = developer.name
    entity.image = UIImagePNGRepresentation(developer.image)! as Data
    entity.goldBadges = Int16(developer.goldenBadges)
    entity.silverBadges = Int16(developer.silverBadges)
    entity.bronzeBadges = Int16(developer.bronzeBadges)
    entity.location = developer.location
    entity.timeOfTheRequest = developer.timeOfTheRequest
    
    
    //for either case, save the data in the coreData's context:
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func fetchListFromDisk()
{
    //var list = [DeveloperCD]()
    
    //fetch data from coreData and assign it to the local array so that we can have easier access to it:
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do
    {
        rawDataFromDisk = try context.fetch(DeveloperCD.fetchRequest())
    }
    catch
    {
        
    }
    
   
}


func deleteRecordsCD() -> Void {
    
    //context for coredata
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let moc = context
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeveloperCD")
    
    let result = try? moc.fetch(fetchRequest)
    let resultData = result as! [DeveloperCD]
    
    for object in resultData {
        moc.delete(object)
    }
    
    do {
        try moc.save()
        print("saved!")
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
    }
    
}



