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
    
    func configButton() {
        defaultButton.setTitle("Create", for: .normal)
    }
    
    func blurScreen() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeBlur), name: Notification.Name("removeBlur"), object: nil)
        configButton()
    }
    
    @objc func removeBlur(notification: Notification) {
        self.removeBlurEffect()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("removeBlur"), object: nil)
    }
}
