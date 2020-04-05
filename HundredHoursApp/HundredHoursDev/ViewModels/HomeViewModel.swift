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
    
    func setCellLabelFont(_ cell: GoalCollectionCell, _ text: String?) {
        guard let text = text else { return }
        if text.count > 10 {
            cell.cellLabel.font = UIFont.smallerTitleFont
        } else {
            cell.cellLabel.font = UIFont.goalTitleFont
        }
    }
    
    func configure(_ cell: GoalCollectionCell, _ goal: Goal) {
        guard let title = goal.title, let description = goal.goalDescription else { return }
        setCellLabelFont(cell, title)
        cell.cellLabel.text = title
        cell.cellTextView.text = description
    }
    
    func animateBar(_ goal: Goal, _ cell: GoalCollectionCell) {
        let percentage = calcPercent(goal: goal)
        let layer = cell.progressBar.shapeLayer
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = percentage
        basicAnimation.duration = 3
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.setValue(layer, forKey: "stroke")
        layer.add(basicAnimation, forKey: nil)
    }
    
    func updateCurrentTime(goal: Goal, seconds: Int) {
        goal.currSeconds = goal.currSeconds + Int64(seconds)
        CoreDataManager.sharedManager.saveContext()
    }
    
    func removeNotification(_ notificationObj: NotificationService, _ id: String) {
        notificationObj.removeNotificationRequest(id)
    }
}
