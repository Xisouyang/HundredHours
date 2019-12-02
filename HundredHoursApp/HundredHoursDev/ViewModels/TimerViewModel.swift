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
        let date = Date()
        let dateFormatter = DateFormatter()
        let sessionFormatter = DateComponentsFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.none
        sessionFormatter.unitsStyle = .brief
        guard let sessionString =
            sessionFormatter.string(from: TimeInterval(seconds)) else { return "" }
        return "\(dateFormatter.string(from: date)) - \(sessionString)"
    }
    
    func getSeconds() -> Int {
        return seconds
    }
}
