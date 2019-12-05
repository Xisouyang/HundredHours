//
//  NewGoalViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/12/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class GoalFieldsViewModel {
    
    func setGoalDuration(sender: UIDatePicker) -> Int {
        let date = sender.date
        let minComponent = Calendar.current.component(.minute, from: date)
        let hourComponent = Calendar.current.component(.hour, from: date)
        let minToSecs = minComponent * 60
        let hourToSecs = hourComponent * 3600
        let total = minToSecs + hourToSecs
        return total
    }
}
