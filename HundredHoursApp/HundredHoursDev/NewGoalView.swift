//
//  NewGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/5/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

// TODO: character limit for text fields

import UIKit

class NewGoalView: UIView {
    
    let goalNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Goal Name"
        label.font = UIFont(name: "HelveticaNeue", size: 35)
        return label
    }()
    
    let goalHoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Hours"
        label.font = UIFont(name: "HelveticaNeue", size: 35)
        return label
    }()
    
    let goalNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue", size: 25)
        textField.placeholder = "goal name here"
        return textField
    }()
    
    let goalHoursTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue", size: 25)
        textField.placeholder = "100"
        return textField
    }()
    
    let goalNameTextLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return view
    }()
    
    let goalHoursTextLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        
        addSubview(goalNameLabel)
        addSubview(goalNameTextField)
        addSubview(goalNameTextLine)
        addSubview(goalHoursLabel)
        addSubview(goalHoursTextField)
        addSubview(goalHoursTextLine)
        
        goalNameLabelConstraints()
        goalNameTextFieldConstraints()
        goalNameLineConstraints()
        goalHoursLabelConstraints()
        goalHoursTextFieldConstraints()
        goalHoursTextLineConstraints()
    }
    
    func goalNameLabelConstraints() {
        goalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        goalNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        goalNameLabel.heightAnchor.constraint(equalToConstant: 70)
        goalNameLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2).isActive = true
        goalNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 32).isActive = true
    }
    
    func goalHoursLabelConstraints() {
        
        goalHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        goalHoursLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        goalHoursLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        goalHoursLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2).isActive = true
        goalHoursLabel.topAnchor.constraint(equalToSystemSpacingBelow: goalNameLabel.bottomAnchor, multiplier: 20).isActive = true
    }
    
    func goalNameTextFieldConstraints() {
        goalNameTextField.translatesAutoresizingMaskIntoConstraints = false
        goalNameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        goalNameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        goalNameTextField.topAnchor.constraint(equalTo: goalNameLabel.bottomAnchor, constant: 10).isActive = true
        goalNameTextField.leftAnchor.constraint(equalTo: goalNameLabel.leftAnchor).isActive = true
    }
    
    func goalHoursTextFieldConstraints() {
        goalHoursTextField.translatesAutoresizingMaskIntoConstraints = false
        goalHoursTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        goalHoursTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        goalHoursTextField.topAnchor.constraint(equalTo: goalHoursLabel.bottomAnchor, constant: 10).isActive = true
        goalHoursTextField.leftAnchor.constraint(equalTo: goalHoursLabel.leftAnchor).isActive = true
    }
    
    func goalNameLineConstraints() {
        goalNameTextLine.translatesAutoresizingMaskIntoConstraints = false
        goalNameTextLine.widthAnchor.constraint(equalTo: goalNameTextField.widthAnchor).isActive = true
        goalNameTextLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        goalNameTextLine.topAnchor.constraint(equalToSystemSpacingBelow: goalNameTextField.topAnchor, multiplier: 6).isActive = true
        goalNameTextLine.leftAnchor.constraint(equalTo: goalNameTextField.leftAnchor).isActive = true
    }
    
    func goalHoursTextLineConstraints() {
        
        goalHoursTextLine.translatesAutoresizingMaskIntoConstraints = false
        goalHoursTextLine.widthAnchor.constraint(equalTo: goalHoursTextField.widthAnchor).isActive = true
        goalHoursTextLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        goalHoursTextLine.topAnchor.constraint(equalToSystemSpacingBelow: goalHoursTextField.topAnchor, multiplier: 6).isActive = true
        goalHoursTextLine.leftAnchor.constraint(equalTo: goalHoursTextField.leftAnchor).isActive = true
    }
}
