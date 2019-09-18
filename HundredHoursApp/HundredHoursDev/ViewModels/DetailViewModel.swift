//
//  DetailViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailViewModel {
    
    var goal: NSManagedObject
    
    init(goal: NSManagedObject) {
        self.goal = goal
    }
    
    func calcPercent() -> CGFloat {
        
        let curHours = goal.value(forKey: "currentHours") as! CGFloat
        let totHours = goal.value(forKey: "totalHours") as! CGFloat
        var percentage = curHours / totHours
        
        if percentage > 1 {
            percentage = 1
        }
        return percentage
    }
}
