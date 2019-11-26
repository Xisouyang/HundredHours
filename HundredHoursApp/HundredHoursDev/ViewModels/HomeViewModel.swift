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
        let secondsInMin = 60
        let goalName = goalsArr[indexPath.row].value(forKey: "title") as! String
        let goalSeconds = goalsArr[indexPath.row].value(forKey: "totalSeconds") as! Int
        let goalHours = goalSeconds / secondsInHour
        let remainder = goalSeconds % secondsInHour
        let goalMin = remainder / secondsInMin
        let cellString = computeCellString(goalName: goalName, goalHours: String(goalHours), goalMins: String(goalMin))
        return cellString
    }

    func resizeCell(indexPath: IndexPath, view: UICollectionView) -> CGFloat {
        // returns height to resize cell based on goal description text
        let goal = goalsArr[indexPath.row]
        let textLabel = UILabel()
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.text = goal.goalDescription
        textLabel.font = UIFont.goalDescriptionFont
        let height = textLabel.sizeThatFits(CGSize(width: (view.bounds.width * 0.75), height: CGFloat.greatestFiniteMagnitude)).height
        return height
    }
    
    func populateGoalList() -> [Goal] {
        guard let unwrappedGoalObjs = CoreDataManager.sharedManager.fetchAllGoals() else { return [] }
        return unwrappedGoalObjs 
    }
    
    func deleteGoal(index: Int, goalList: [Goal]) -> [Goal]? {
        var mutableList = goalList
        let goal = goalList[index]
        CoreDataManager.sharedManager.removeItem(objectID: goal.objectID)
        CoreDataManager.sharedManager.saveContext()
        mutableList.remove(at: index)
        return mutableList
    }
    
    func computeCellString(goalName: String, goalHours: String, goalMins: String) -> String {
        var result: String = ""
        if let minutes = Int(goalMins),
            let hours = Int(goalHours) {
            if minutes == 1 && hours == 1 {
                result = goalName + " - " + goalHours + " HR " + goalMins + " MIN"
            } else if (minutes > 1 || minutes < 1) && hours == 1 {
                result = goalName + " - " + goalHours + " HR " + goalMins + " MINS"
            } else if minutes == 1 && (hours > 1 || hours < 1) {
                result = goalName + " - " + goalHours + " HRS " + goalMins + " MIN"
            } else if (minutes > 1 || minutes < 1) && (hours > 1 || hours < 1) {
                 result = goalName + " - " + goalHours + " HRS " + goalMins + " MINS"
            }
        }
        return result
    }
}
