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
    
    var timeStampsArr = [String]()
    
    func calcPercent(goal: NSManagedObject) -> CGFloat {
        let curHours = goal.value(forKey: "currSeconds") as! CGFloat
        let totHours = goal.value(forKey: "totalSeconds") as! CGFloat
        var percentage = curHours / totHours
        if percentage > 1 {
            percentage = 1
        }
        return percentage
    }
    
    func saveTimeStamp(time: Int, goal: Goal) {
        CoreDataManager.sharedManager.createTimestamp(time: time, goal: goal)
    }
    
    func populateStampsArr(goal: Goal) {
        let timeStamps = CoreDataManager.sharedManager.fetchTimeStamps(goal: goal)
        for timeStamp in timeStamps {
            let sessionString = getTimeLabel(timeStamp: timeStamp)
            timeStampsArr.append(sessionString)
        }
    }

    func getTimeLabel(timeStamp: Timestamps) -> String {
        guard let day = timeStamp.day else { return "" }
        let seconds = Int(timeStamp.session)
        let dateFormatter = DateFormatter()
        let sessionFormatter = DateComponentsFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.none
        sessionFormatter.unitsStyle = .brief
        guard let sessionString =
            sessionFormatter.string(from: TimeInterval(seconds)) else { return "" }
        return "\(dateFormatter.string(from: day as Date)) - \(sessionString)"
    }
    
    func updateCurrentTime(goal: Goal, seconds: Int) {
        goal.currSeconds = goal.currSeconds + Int64(seconds)
        CoreDataManager.sharedManager.saveContext()
    }
}
