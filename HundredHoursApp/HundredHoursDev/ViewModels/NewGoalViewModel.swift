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
    
    func checkFieldError(name: String, hourString: String) -> Bool {
        var error = false
        if name.isEmpty || hourString.isEmpty {
            error = true
        }
        if Int(hourString) == nil {
            error = true
        }
        return error
    }
    
    func addGoal(name: String, hourString: String) {
        guard var goalHours = Int(hourString) else { return }
        goalHours = goalHours * 3600
        CoreDataManager.sharedManager.createGoal(name: name, hours: goalHours)
    }
}
