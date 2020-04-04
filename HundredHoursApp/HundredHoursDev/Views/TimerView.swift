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
    private var instructionLabel = UILabel()
    
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
        instructionLabel = createInstructionLabel()
        self.addSubview(watchView)
        watchView.addSubview(watchLabel)
        watchView.addSubview(instructionLabel)
        watchLabelConstraints()
        instructionLabelConstraints()
        self.addGestureRecognizer(tapGesture)
    }
    
    private func createWatchView() -> UIView {
        let view = UIView()
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.frame = viewFrame
        view.center = self.center
        view.backgroundColor = #colorLiteral(red: 0.6726701856, green: 0.005906813312, blue: 1, alpha: 1)
        return view
    }
    
    private func createWatchLabel() -> UILabel {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.timerFont
        label.textAlignment = .center
        return label
    }

    private func createInstructionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Tap to quit"
        label.textAlignment = .center
        label.font = UIFont.timerLabelFont
        label.textColor = .white
        return label
    }
    
    private func watchLabelConstraints() {
        watchLabel.translatesAutoresizingMaskIntoConstraints = false
        watchLabel.centerXAnchor.constraint(equalTo: watchView.centerXAnchor).isActive = true
        watchLabel.centerYAnchor.constraint(equalTo: watchView.centerYAnchor).isActive = true
        watchLabel.widthAnchor.constraint(equalTo: watchView.widthAnchor, multiplier: 0.8).isActive = true
        watchLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func instructionLabelConstraints() {
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: watchLabel.safeAreaLayoutGuide.bottomAnchor),
            instructionLabel.centerXAnchor.constraint(equalTo: watchView.centerXAnchor),
            instructionLabel.widthAnchor.constraint(equalTo: watchView.widthAnchor, multiplier: 0.8),
            instructionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
