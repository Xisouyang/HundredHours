//
//  HomeViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/12/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class HomeViewModel {
    
    var goalsArr: [Goal] = []
    
    func getCellString(indexPath: IndexPath) -> String {
        let secondsInHour = 3600
        let goalName = goalsArr[indexPath.row].value(forKey: "title") as! String
        let goalSeconds = goalsArr[indexPath.row].value(forKey: "totalSeconds") as! Int
        let goalHours = goalSeconds / secondsInHour
        let cellString = getCellString(goalName: goalName, goalHours: String(goalHours))
        return cellString
    }
    
    func populateGoalList() -> [Goal] {
        guard let unwrappedGoalObjs = CoreDataManager.sharedManager.fetchAllGoals() else { return [] }
        return unwrappedGoalObjs 
    }
    
    func deleteGoal(indexPath: IndexPath, goalList: [Goal]) -> [Goal]? {
        var mutableList = goalList
        let goal = goalList[indexPath.row]
        CoreDataManager.sharedManager.removeItem(objectID: goal.objectID)
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
