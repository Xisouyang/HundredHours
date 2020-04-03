//
//  NoGoalsView.swift
//  100HoursDev
//
//  Created by Stephen Ouyang on 9/4/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class NoGoalsHomeView: UIView {
    
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var emptyImageView = UIImageView()
    var startButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.6666713357, green: 0, blue: 1, alpha: 1)
        titleLabel = createTitleLabel()
        descriptionLabel = createDescriptionLabel()
        emptyImageView = createEmptyImage()
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(emptyImageView)
        titleLabelConstraints()
        descriptionLabelConstraints()
        imageViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                                                
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Let's Do It"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.emptyStateTitleFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Once you create a goal it will show up here"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.emptyStateDescriptionFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func createStartButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.668626368, green: 0, blue: 1, alpha: 1)
        button.setTitle("New Goal", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }

    private func createEmptyImage() -> UIImageView {
        let image = UIImage(named: "emptyStateIconSVG")
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: emptyImageView.safeAreaLayoutGuide.bottomAnchor, multiplier: 3),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func imageViewConstraints() {
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 7),
            emptyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            emptyImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35)
        ])
    }
}
