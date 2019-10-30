//
//  OnboardViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/25/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

class OnboardViewModel {
    
    let dataSource: [OnboardItem] = [
        OnboardItem(title: "Create Goal", description: "Create a goal or activity to keep track of", imgName: "createIcon"),
        OnboardItem(title: "Start Timer", description: "Start timer when you're ready to work on your goal or activity", imgName: "timerIcon"),
        OnboardItem(title: "Track Progress", description: "Visually track your progress", imgName: "progressIcon")
    ]
}
