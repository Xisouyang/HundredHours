//
//  CoreDataManager.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/9/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // MARK: - Core Data stack
    
    // Core Data singleton
    static let sharedManager = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "HundredHoursDev")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    // create instance of context, an object that manages all the saved data
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
          
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createGoalTitleObj(name: String) {
        
        // create storyboard entity
        let entity = NSEntityDescription.entity(forEntityName: "GoalTitle", in: context)
        guard let unwrappedEntity = entity else {
            print("FAILURE: entity unable to be unwrapped: \(String(describing: entity))")
            return
        }
        // create storyboard object using entity
        let object = NSManagedObject(entity: unwrappedEntity, insertInto: context)
        object.setValue(name, forKey: "name")
        
        // save
        saveContext()
    }
    
    func fetchAllGoalTitleObjs() -> [NSManagedObject]? {
        
        var goalNameArr: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GoalTitle")
        
        do {
            goalNameArr = try context.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return goalNameArr
    }
    
    func fetchGoalTitleObj(name: String) -> NSManagedObject? {
        
        var goalNameArr: [NSManagedObject] = []
        var goalNameObj: NSManagedObject?
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GoalTitle")
        fetchRequest.predicate = NSPredicate(format: "%@ = name", name)
        
        do {
            goalNameArr = try context.fetch(fetchRequest)
            if !goalNameArr.isEmpty {
                goalNameObj = goalNameArr.first
            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return goalNameObj
    }

}
