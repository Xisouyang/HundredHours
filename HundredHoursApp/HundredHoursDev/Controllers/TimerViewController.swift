//
//  TimerViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    //TODO: check if any of these are accessed outside the class, if not, turn them into private
    private var timer = Timer()
    private let timerView = TimerView(frame: UIScreen.main.bounds)
    let timerViewModel = TimerViewModel()

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
        NotificationCenter.default.post(name: Notification.Name("timerVC dismissed"), object: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateTimer() {
        timerViewModel.seconds += 1
        timerView.watchLabel.text = timerViewModel.timeString(time: TimeInterval(timerViewModel.seconds))
    }
}
