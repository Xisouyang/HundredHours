//
//  HomeViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/12/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import CoreData

class HomeViewModel {
    
    func populateGoalList() -> [NSManagedObject] {
        
        guard let unwrappedGoalObjs = CoreDataManager.sharedManager.fetchAllGoals() else { return [] }
        return unwrappedGoalObjs
    }
    
//    func deleteGoal(indexPath: IndexPath) {
//
//        let goalName = goalsArr[indexPath.row].value(forKey: "title")
//        let goalToRemove = CoreDataManager.sharedManager.fetchGoal(name: goalName as! String)
//        let goalID = goalToRemove?.objectID
//        guard let unwrappedID = goalID else { return }
//        CoreDataManager.sharedManager.removeItem(objectID: unwrappedID)
//        CoreDataManager.sharedManager.saveContext()
//        goalsArr.remove(at: indexPath.row)
//    }
    
    func deleteGoal(indexPath: IndexPath, goalList: [NSManagedObject]) -> [NSManagedObject]? {
        
        var mutableList = goalList
        guard let goalName = goalList[indexPath.row].value(forKey: "title") else { return nil }
        let goalToRemove = CoreDataManager.sharedManager.fetchGoal(name: goalName as! String)
        let goalID = goalToRemove?.objectID
        guard let unwrappedID = goalID else { return nil }
        CoreDataManager.sharedManager.removeItem(objectID: unwrappedID)
        CoreDataManager.sharedManager.saveContext()
        mutableList.remove(at: indexPath.row)
        return mutableList
    }
    
    func getCellString(goalName: String, goalHours: String) -> String {
        
        var result: String = ""
        
        if Int(goalHours) == 1 {
            result = goalName + " - " + goalHours + " HOUR"
        } else {
            result = goalName + " - " + goalHours + " HOURS"
        }
        return result
    }
}
