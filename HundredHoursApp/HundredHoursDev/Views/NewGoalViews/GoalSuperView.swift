//
//  NewGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GoalSuperView: UIView {
    
    var defaultButton = UIButton()
    var errorLabel = UILabel()
    let goalNameField = NewGoalFormField(text: "Goal Name", frame: .zero)
    let goalHourField = NewGoalFormField(text: "Total Hours", frame: .zero)
    let goalDescriptionField = NewGoalDescriptionStack(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        configView()
        goalNameField.formField.textField.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        defaultButton = createButton()
        errorLabel = createErrorLabel()
        addSubview(defaultButton)
        addSubview(goalNameField)
        addSubview(goalHourField)
        addSubview(goalDescriptionField)
        addSubview(errorLabel)
        goalNameConstraints()
        goalHourConstraints()
        errorLabelConstraints()
        goalDescriptionConstraints()
        buttonConstraints()
        goalNameField.configPlaceholder(text: "Enter Goal Name")
        goalHourField.configPlaceholder(text: "Number of Hours")
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.setTitle("default", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.isEnabled = false
        button.layer.cornerRadius = 25
        button.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        return button
    }
    
    private func createErrorLabel() -> UILabel {
        let label = UILabel()
        label.text = "x  Must be whole number greater than 0"
        label.font = UIFont(name: "Avenir", size: 16)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }
    
    private func buttonConstraints() {
        defaultButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            defaultButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            defaultButton.heightAnchor.constraint(equalToConstant: 50),
            defaultButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            defaultButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func goalNameConstraints() {
        goalNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalNameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
             goalNameField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            goalNameField.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            goalNameField.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 20)
        ])
    }
    
    private func goalHourConstraints() {
        goalHourField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalHourField.widthAnchor.constraint(equalTo: goalNameField.widthAnchor),
            goalHourField.heightAnchor.constraint(equalTo: goalNameField.heightAnchor),
            goalHourField.leftAnchor.constraint(equalTo: goalNameField.leftAnchor),
            goalHourField.topAnchor.constraint(equalTo: goalNameField.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func errorLabelConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(equalTo: goalHourField.widthAnchor),
            errorLabel.heightAnchor.constraint(equalTo: goalHourField.heightAnchor, multiplier: 0.4),
            errorLabel.leftAnchor.constraint(equalTo: goalHourField.leftAnchor),
            errorLabel.topAnchor.constraint(equalTo: goalHourField.safeAreaLayoutGuide.bottomAnchor, constant: -35)
        ])
    }
    
    private func goalDescriptionConstraints() {
        goalDescriptionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalDescriptionField.widthAnchor.constraint(equalTo: goalHourField.widthAnchor),
            goalDescriptionField.heightAnchor.constraint(equalTo: goalHourField.heightAnchor, multiplier: 0.8),
            goalDescriptionField.leftAnchor.constraint(equalTo: goalHourField.leftAnchor),
            goalDescriptionField.topAnchor.constraint(equalTo: errorLabel.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
