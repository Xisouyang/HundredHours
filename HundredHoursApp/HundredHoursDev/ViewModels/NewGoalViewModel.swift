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
    
    func setGoalDuration(hours: Int) -> Int {
        let hoursToSeconds = 3600 * hours
        return hoursToSeconds
    }
}
