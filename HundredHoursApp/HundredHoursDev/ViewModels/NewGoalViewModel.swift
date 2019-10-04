//
//  NewGoalViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/12/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class NewGoalViewModel {
    
    //TODO: validate the length od the goal's name, max ~15
    func checkTextFields(name: String, hourString: String) -> Bool {
        var shouldPresentError = false
        //TODO: use .isEmpty instead of == ""
        if name == "" || hourString == "" {
            shouldPresentError = true
        }
        if Int(hourString) == nil {
            shouldPresentError = true
        }
        return shouldPresentError
    }
    
    func addGoal(name: String, hourString: String) {
        guard var goalHours = Int(hourString) else { return }
        goalHours = goalHours * 3600
        CoreDataManager.sharedManager.createGoal(name: name, hours: goalHours)
    }
}
