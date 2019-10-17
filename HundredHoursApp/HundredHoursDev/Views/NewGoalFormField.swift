//
//  NewGoalFormField.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class NewGoalFormField: UIView {
    
    let formField = NewGoalStack()
    let formLine = UIView()
    private var fieldString: String
    
    init(text: String, frame: CGRect) {
        self.fieldString = text
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        configTextFont()
    }
    
    private func commonInit() {
        addSubview(formField)
        addSubview(formLine)
        formFieldConstraints()
        formLineConstraints()
        configFormLine()
        formField.textLabel.text = fieldString
    }
    
    private func configFormLine() {
        formLine.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func configTextFont() {
        let goalLabelFontSize = self.formField.textLabel.frame.height * 0.4
        let goalFieldFontSize = self.formField.textField.frame.height * 0.25
        formField.textLabel.font = UIFont(name: "HelveticaNeue", size: goalLabelFontSize)
        formField.textField.font = UIFont(name: "HelveticaNeue", size: goalFieldFontSize)
    }
    
    private func formFieldConstraints() {
        formField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [formField.widthAnchor.constraint(equalTo: self.widthAnchor),
             formField.heightAnchor.constraint(equalTo: self.heightAnchor),
             formField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
             formField.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    private func formLineConstraints() {
        formLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
           [formLine.widthAnchor.constraint(equalTo: formField.widthAnchor),
            formLine.heightAnchor.constraint(equalToConstant: 1),
            formLine.leftAnchor.constraint(equalTo: formField.leftAnchor),
            formLine.topAnchor.constraint(equalToSystemSpacingBelow: formField.textField.topAnchor, multiplier: 7.5)])
    }
}
