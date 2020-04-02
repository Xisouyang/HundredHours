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
    private var emptyImageView = UIImageView()
    var startButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel = createTitleLabel()
        startButton = createStartButton()
        emptyImageView = createEmptyImage()
        addSubview(titleLabel)
        addSubview(startButton)
        addSubview(emptyImageView)
        titleLabelConstraints()
        buttonConstraints()
        imageViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                                                
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Let's get it"
        label.textAlignment = .center
        label.font = UIFont.emptyStateTitleFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func createStartButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        button.layer.cornerRadius = 25
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
            titleLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func buttonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
             startButton.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.safeAreaLayoutGuide.bottomAnchor, multiplier: 5),
             startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
             startButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
             startButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func imageViewConstraints() {
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 11),
            emptyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
            emptyImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25)
        ])
    }
}
