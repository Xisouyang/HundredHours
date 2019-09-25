//
//  CreateGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class NewGoalView: GoalSuperView {
    
    var viewModel = NewGoalViewModel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeBlur), name: Notification.Name("removeBlur"), object: nil)
        configButton()
    }
    
    func configButton() {
        defaultButton.setTitle("Create", for: .normal)
    }
    
    @objc func removeBlur(notification: Notification) {
        self.removeBlurEffect()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("removeBlur"), object: nil)
    }
}
