//
//  OnboardViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/25/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

class OnboardViewModel {
    
    let dataSource: [OnboardText] = [
        OnboardText(title: "Create a Goal", description: "Create a goal to keep track of"),
        OnboardText(title: "Hours Only", description: "Be sure to only input whole numbers that represent the number of hours for the goal"),
        OnboardText(title: "Track Your Progress", description: "Track progress using the circular bar. Swipe up to see all timed sessions. Tap timer to start session, tap again to exit")
    ]
}
