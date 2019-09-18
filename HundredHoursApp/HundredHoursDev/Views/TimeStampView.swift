//
//  TimeStampsView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/17/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class TimeStampsView: UIView {
    
    let timeStampTitle: UILabel = {
        let label = UILabel()
        label.text = "Time Stamps"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 25
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        addSubview(timeStampTitle)
        titleConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleConstraints() {
        
        timeStampTitle.translatesAutoresizingMaskIntoConstraints = false
        timeStampTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        timeStampTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        timeStampTitle.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 2).isActive = true
        timeStampTitle.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2).isActive = true
    }
}
