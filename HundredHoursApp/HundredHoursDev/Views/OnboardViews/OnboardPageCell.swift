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
    var onboardText: OnboardText? {
        didSet {
            // prevent codes from crashing if data source
            guard let unwrappedText = onboardText else { return }
            titleLabel = configLabel(text: unwrappedText.title, font: UIFont.titleFont)
            descriptionLabel = configLabel(text: unwrappedText.description, font: UIFont.descriptionFont)
            setupView()
        }
    }
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    private func setupView() {
        contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        titleLabelConstraints()
        descriptionLabelConstraints()
    }
    
    private func configLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = text
        label.textAlignment = .center
        label.font = font
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 3),
            descriptionLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 5)
        ])
    }
}
