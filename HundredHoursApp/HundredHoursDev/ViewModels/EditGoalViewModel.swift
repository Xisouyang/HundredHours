//
//  EditGoalViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 12/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

class EditGoalViewModel {

    func editGoalDuration(goal: Goal) -> Int {
        let newDuration = Int(exactly: goal.totalSeconds)
        guard let goalDuration = newDuration else { return 0 }
        return goalDuration
    }
}
