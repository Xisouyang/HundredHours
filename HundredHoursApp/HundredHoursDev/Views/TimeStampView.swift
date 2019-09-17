//
//  TimeStampsView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/17/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class TimeStampsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 25
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
