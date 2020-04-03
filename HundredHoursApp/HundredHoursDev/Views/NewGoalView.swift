//
//  NewGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 4/2/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol NewGoalViewDelegate: class {
    func startButtonDidPress()
}

class NewGoalView: UIView {

    var goalFieldsViewModel = NewGoalViewModel()
    let goalNameField = GoalFieldView(.zero)
    let goalDurationField = GoalFieldView(.zero)
    let goalDescriptionView: UITextView = {
        let view = UITextView()
        view.font = UIFont.newGoalFieldFont
        view.text = "Describe Goal.."
        view.textColor = .lightGray
        view.backgroundColor = #colorLiteral(red: 0.6853155494, green: 0, blue: 1, alpha: 1)
        return view
    }()
    let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.668626368, green: 0, blue: 1, alpha: 1)
        button.setTitle("Let's Go", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.5990509987, green: 0.6041648984, blue: 0.599606812, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    weak var delegate: NewGoalViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.6881616712, green: 0, blue: 1, alpha: 1)
        configView()
        goalNameField.formField.becomeFirstResponder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configView() {
        addSubview(goalNameField)
        addSubview(goalDurationField)
        addSubview(goalDescriptionView)
        addSubview(startButton)
        goalNameConstraints()
        goalDescriptionConstraints()
        goalDurationConstraints()
        startButtonConstraints()
        goalNameField.configPlaceholder(text: "Let's give your goal a name")
        goalDurationField.configPlaceholder(text: "How long? e.g. '2' for 2 hours")
        goalDurationField.formField.keyboardType = .numberPad
    }

    func highlightLine(line: UIView) {
        line.layer.borderWidth = 2
        line.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    func unhighlightLine(line: UIView) {
        line.layer.borderWidth = 0
        line.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    @objc private func startTapped() {
        delegate?.startButtonDidPress()
    }

    private func goalNameConstraints() {
        goalNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalNameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            goalNameField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.04),
            goalNameField.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            goalNameField.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 30)
        ])
    }
    
    private func goalDurationConstraints() {
        goalDurationField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalDurationField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            goalDurationField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.04),
            goalDurationField.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            goalDurationField.topAnchor.constraint(equalToSystemSpacingBelow: goalNameField.safeAreaLayoutGuide.bottomAnchor, multiplier: 12)
        ])
    }
    
    private func goalDescriptionConstraints() {
        goalDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalDescriptionView.topAnchor.constraint(equalToSystemSpacingBelow: goalDurationField.safeAreaLayoutGuide.bottomAnchor, multiplier: 12),
            goalDescriptionView.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2),
            goalDescriptionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            goalDescriptionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func startButtonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -38),
            startButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

