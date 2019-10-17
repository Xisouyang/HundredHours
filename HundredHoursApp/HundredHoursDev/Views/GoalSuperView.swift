//
//  NewGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GoalSuperView: UIView {
    
    var defaultButton: UIButton = {
        let button = UIButton()
        button.setTitle("default", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        return button
    }()
    
    let goalNameField = NewGoalFormField(text: "Goal Name", frame: .zero)
    let goalHourField = NewGoalFormField(text: "Total Hours", frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        configView()
        goalNameField.formField.textField.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        addSubview(defaultButton)
        addSubview(goalNameField)
        addSubview(goalHourField)
        goalNameConstraint()
        goalHourConstraint()
        buttonConstraints()
    }
    
    func buttonConstraints() {
        defaultButton.translatesAutoresizingMaskIntoConstraints = false
        defaultButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        defaultButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        defaultButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        defaultButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    private func goalNameConstraint() {
        goalNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [goalNameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
             goalNameField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            goalNameField.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            goalNameField.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 25)])
    }
    
    private func goalHourConstraint() {
        goalHourField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
           [goalHourField.widthAnchor.constraint(equalTo: goalNameField.widthAnchor),
            goalHourField.heightAnchor.constraint(equalTo: goalNameField.heightAnchor),
            goalHourField.leftAnchor.constraint(equalTo: goalNameField.leftAnchor),
            goalHourField.topAnchor.constraint(equalTo: goalNameField.safeAreaLayoutGuide.bottomAnchor)])
    }
}
