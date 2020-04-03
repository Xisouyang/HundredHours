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
    
    func removeNotification(_ notificationObj: NotificationService, _ id: String) {
        notificationObj.removeNotificationRequest(id)
    }
}
