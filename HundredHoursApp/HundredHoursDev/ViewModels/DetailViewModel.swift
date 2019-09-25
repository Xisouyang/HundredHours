//
//  DetailViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/*
 TODO: create functionality to start timer view here
       create functionality to stop and swipe timer down here
 */

import Foundation
import UIKit
import CoreData

class DetailViewModel {
    
    func calcPercent(goal: NSManagedObject) -> CGFloat {
        let curHours = goal.value(forKey: "currentHours") as! CGFloat
        let totHours = goal.value(forKey: "totalHours") as! CGFloat
        var percentage = curHours / totHours
        if percentage > 1 {
            percentage = 1
        }
        return percentage
    }
}
