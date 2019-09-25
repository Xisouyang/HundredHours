//
//  TimerViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var timer = Timer()
    let timerView = TimerView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timerView)
        view.backgroundColor = .clear
        timerView.tapGesture.addTarget(self, action: #selector(timerViewTapped))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timerView.frame = view.frame
    }
    
    @objc func timerViewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateTimer() {
        timerView.model.seconds += 1
        timerView.watchLabel.text = timerView.model.timeString(time: TimeInterval(timerView.model.seconds))
    }
}
