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
    
}
