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
    
    func getCellString(goalName: String, goalHours: String) -> String {
        
        var result: String = ""
        
        if Int(goalHours) == 1 {
            result = goalName + " - " + goalHours + " HOUR"
        } else {
            result = goalName + " - " + goalHours + " HOURS"
        }
        return result
    }
    
    func populateGoalList() -> [NSManagedObject] {
        
        guard let unwrappedGoalObjs = CoreDataManager.sharedManager.fetchAllGoals() else { return [] }
        return unwrappedGoalObjs
    }
}
