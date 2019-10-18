//
//  NewGoalTextField.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/* TODO: Switch items in stackview: instead of line and textField, do label and textField.
   Keep line separate from stackview, keep line in the formField class instead.
 */

import UIKit

class NewGoalStack: UIStackView {
    
    var textField = UITextField()
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        configStack()
        textLabel = createFormLabel()
        textField = createTextField()
        addArrangedSubview(textLabel)
        addArrangedSubview(textField)
        textLabelConstraints()
    }
    
    private func configStack() {
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 0
    }
    
    private func createFormLabel() -> UILabel {
        let label = UILabel()
        return label
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        return textField
    }
    
    func textLabelConstraints() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
    }
}
