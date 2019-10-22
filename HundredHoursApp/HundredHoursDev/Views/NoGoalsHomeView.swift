//
//  NoGoalsView.swift
//  100HoursDev
//
//  Created by Stephen Ouyang on 9/4/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class NoGoalsHomeView: UIView {
    
    private var emptyStateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emptyStateLabel = createEmptyStateLabel()
        self.addSubview(emptyStateLabel)
        labelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createEmptyStateLabel() -> UILabel {
        let label = UILabel()
        label.text = "Get started with a new goal!"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 25)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func labelConstraints() {
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyStateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        emptyStateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        emptyStateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
