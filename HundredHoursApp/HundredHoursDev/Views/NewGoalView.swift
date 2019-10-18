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
        configButton()
    }
    
    func configButton() {
        defaultButton.setTitle("Create", for: .normal)
    }
    
    func removeBlur() {
        self.removeBlurEffect()
    }
    
    func addBlur() {
        self.blurScreen()
    }
    
    func highlightLine(line: UIView) {
        line.layer.borderWidth = 2
        line.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func unhighlightLine(line: UIView) {
        line.layer.borderWidth = 0
        line.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
}
