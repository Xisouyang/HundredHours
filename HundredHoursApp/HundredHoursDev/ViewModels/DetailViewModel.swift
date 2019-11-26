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
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func getTimeLabel(timeStamp: Timestamps) -> String {
        guard let day = timeStamp.day else { return "" }
        let seconds = Int(timeStamp.session)
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        return "\(formatter.string(from: day as Date)) - \(timeString(time: TimeInterval(seconds)))"
    }
    
    func updateCurrentTime(goal: Goal, seconds: Int) {
        goal.currSeconds = goal.currSeconds + Int64(seconds)
        CoreDataManager.sharedManager.saveContext()
    }
}
