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
    
    func checkTextFields(name: String, hourString: String) -> Bool {
        
        var shouldPresentError = false
        
        if name == "" || hourString == "" {
            shouldPresentError = true
        }
        
        if Int(hourString) == nil {
            shouldPresentError = true
        }
        
        return shouldPresentError
    }
    
    func addGoal(name: String, hourString: String) {
        
        guard let goalHours = Int(hourString) else { return }
        CoreDataManager.sharedManager.createGoal(name: name, hours: goalHours)
    }
}
