//
//  OnboardPage.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class OnboardPageCell: UICollectionViewCell {
    
    static let identifier = "onboarding"
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        titleLabel = configLabel()
        descriptionLabel = configLabel()
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        titleLabelConstraints()
        descriptionLabelConstraints()
    }
    
    private func configLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 30)
        ])
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 0.9),
            descriptionLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.safeAreaLayoutGuide.bottomAnchor, multiplier: 2)
        ])
    }
}
