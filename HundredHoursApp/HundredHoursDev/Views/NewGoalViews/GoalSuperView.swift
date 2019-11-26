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
    var datePickerStack = DatePickerStack()
    let goalNameField = NewGoalFormField(text: "Goal Name", frame: .zero)
    let goalDescriptionField = DescriptionStack(frame: .zero)
    
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
        addSubview(goalNameField)
        addSubview(goalDescriptionField)
        addSubview(datePickerStack)
        goalNameConstraints()
        goalDescriptionConstraints()
        datePickerConstraints()
        goalNameField.configPlaceholder(text: "Enter Goal Name")
    }
    
    private func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return datePicker
    }
    
    private func createErrorLabel() -> UILabel {
        let label = UILabel()
        label.text = "x  Must be whole number greater than 0"
        label.font = UIFont(name: "Avenir", size: 16)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
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
    
    private func goalDescriptionConstraints() {
        goalDescriptionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalDescriptionField.widthAnchor.constraint(equalTo: goalNameField.widthAnchor),
            goalDescriptionField.heightAnchor.constraint(equalTo: goalNameField.heightAnchor, multiplier: 0.8),
            goalDescriptionField.leftAnchor.constraint(equalTo: goalNameField.leftAnchor),
            goalDescriptionField.topAnchor.constraint(equalTo: goalNameField.safeAreaLayoutGuide.bottomAnchor, constant: 50)
        ])
    }
    
    private func datePickerConstraints() {
        datePickerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePickerStack.widthAnchor.constraint(equalTo: self.widthAnchor),
            datePickerStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            datePickerStack.leftAnchor.constraint(equalTo: goalDescriptionField.leftAnchor),
            datePickerStack.topAnchor.constraint(equalTo: goalDescriptionField.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
