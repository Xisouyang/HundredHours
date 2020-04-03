//
//  NewGoalFormField.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GoalFieldView: UIView {
    
    let formField = UITextField()
    let formLine = UIView()
    
    init(_ frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        formField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addSubview(formField)
        addSubview(formLine)
        formFieldConstraints()
        formLineConstraints()
        configFormLine()
    }
    
    private func configFormLine() {
        formLine.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func configPlaceholder(text: String) {
        formField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "Avenir", size: 20) as Any])
    }
    
    private func formFieldConstraints() {
        formField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formField.widthAnchor.constraint(equalTo: self.widthAnchor),
            formField.heightAnchor.constraint(equalTo: self.heightAnchor),
            formField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            formField.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func formLineConstraints() {
        formLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formLine.widthAnchor.constraint(equalTo: formField.widthAnchor),
            formLine.heightAnchor.constraint(equalToConstant: 1.5),
            formLine.leftAnchor.constraint(equalTo: formField.leftAnchor),
            formLine.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
