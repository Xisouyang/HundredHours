//
//  DatePickerStack.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 11/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class DatePickerStack: UIStackView {
    
    var datePickerLabel = UILabel()
    var datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        configStack()
        datePickerLabel = createLabel()
        datePicker = createDatePicker()
        addArrangedSubview(datePickerLabel)
        addArrangedSubview(datePicker)
        labelConstraints()
    }
    
    private func configStack() {
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 0
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "Goal Duration"
        label.font = UIFont.newGoalNameFont
        return label
    }
    
    private func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        return datePicker
    }
    
    private func labelConstraints() {
        datePickerLabel.translatesAutoresizingMaskIntoConstraints = false
        datePickerLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
