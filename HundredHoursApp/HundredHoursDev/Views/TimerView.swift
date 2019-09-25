//
//  TimerView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    let model = TimerViewModel()
    
    var watchView: UIView = {
        
        let view = UIView()
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 1.75, height: UIScreen.main.bounds.height / 4)
        view.frame = viewFrame
        view.layer.cornerRadius = 20
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return view
    }()
    
    var watchLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6026662436)
        self.addSubview(watchView)
        watchView.center = self.center
        watchView.addSubview(watchLabel)
        watchLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func watchLabelConstraints() {
        
        watchLabel.translatesAutoresizingMaskIntoConstraints = false
        watchLabel.centerXAnchor.constraint(equalTo: watchView.centerXAnchor).isActive = true
        watchLabel.centerYAnchor.constraint(equalTo: watchView.centerYAnchor).isActive = true
        watchLabel.widthAnchor.constraint(equalTo: watchView.widthAnchor, multiplier: 0.8).isActive = true
        watchLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
