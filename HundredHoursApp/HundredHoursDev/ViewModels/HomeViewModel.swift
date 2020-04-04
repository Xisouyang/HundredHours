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
    
    func calcPercent(goal: NSManagedObject) -> CGFloat {
        let curHours = goal.value(forKey: "currSeconds") as! CGFloat
        let totHours = goal.value(forKey: "totalSeconds") as! CGFloat
        var percentage = curHours / totHours
        if percentage > 1 {
            percentage = 1
        }
        return percentage
    }
    
    func removeNotification(_ notificationObj: NotificationService, _ id: String) {
        notificationObj.removeNotificationRequest(id)
    }
}
