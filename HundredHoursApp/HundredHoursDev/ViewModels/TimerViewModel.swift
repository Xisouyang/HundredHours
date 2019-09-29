//
//  TimerViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class TimerViewModel {
    
    var seconds = 0
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func getTimeLabel() -> String {
        return "\(timeString(time: TimeInterval(seconds)))"
    }
    
    func getSeconds() -> Int {
        return seconds
    }
}
