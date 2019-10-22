//
//  TimerView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    let tapGesture = UITapGestureRecognizer()
    var watchView = UIView()
    var watchLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        watchView = createWatchView()
        watchLabel = createWatchLabel()
        self.addSubview(watchView)
        watchView.addSubview(watchLabel)
        watchLabelConstraints()
        configTapGesture()
    }
    
    private func createWatchView() -> UIView {
        let view = UIView()
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 1.75, height: UIScreen.main.bounds.height / 4)
        view.frame = viewFrame
        view.center = self.center
        view.layer.cornerRadius = 20
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }
    
    private func createWatchLabel() -> UILabel {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 30)
        label.textAlignment = .center
        return label
    }
    
    private func configTapGesture() {
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    func watchLabelConstraints() {
        watchLabel.translatesAutoresizingMaskIntoConstraints = false
        watchLabel.centerXAnchor.constraint(equalTo: watchView.centerXAnchor).isActive = true
        watchLabel.centerYAnchor.constraint(equalTo: watchView.centerYAnchor).isActive = true
        watchLabel.widthAnchor.constraint(equalTo: watchView.widthAnchor, multiplier: 0.8).isActive = true
        watchLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
