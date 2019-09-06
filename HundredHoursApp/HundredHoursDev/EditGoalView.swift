//
//  EditGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/6/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class EditGoalView: GoalSuperView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configButton() {
        defaultButton.setTitle("Edit", for: .normal)
    }
}
