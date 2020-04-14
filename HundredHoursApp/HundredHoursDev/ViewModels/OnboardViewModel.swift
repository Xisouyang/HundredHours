//
//  OnboardViewModel.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/25/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class OnboardViewModel {
    
    let dataSource: [OnboardItem] = [
        OnboardItem(title: "Create Goal", description: "Create a goal or activity to keep track of", imgName: "createIconSVG"),
        OnboardItem(title: "Start Timer", description: "Start timer by tapping the goal when you're ready to work", imgName: "timerIconSVG"),
        OnboardItem(title: "Track Progress", description: "Visually track your progress for increased motivation", imgName: "progressIconSVG"),
        OnboardItem(title: "Turn on Notifications", description: "Receive reminders to reach your goals", imgName: "notificationsIcon")
    ]
    
    func configure(_ item: OnboardItem, _ imgView: UIImageView , _ titleLabel: UILabel, _ descriptionLabel: UILabel) {
        imgView.image = UIImage(named: item.imgName)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}
