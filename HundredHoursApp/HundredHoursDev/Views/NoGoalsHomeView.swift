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
    private var emptyImageView = UIImageView()
    var startButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emptyStateLabel = createEmptyStateLabel()
        startButton = createStartButton()
        emptyImageView = createEmptyImage()
        addSubview(emptyStateLabel)
        addSubview(startButton)
        addSubview(emptyImageView)
        labelConstraints()
        buttonConstraints()
        imageViewConstraints()
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

    private func createStartButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("CREATE", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        return button
    }

    private func createEmptyImage() -> UIImageView {
        let image = UIImage(named: "emptyStateIconSVG")
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func labelConstraints() {
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyStateLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor),
            emptyStateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            emptyStateLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func buttonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
             startButton.topAnchor.constraint(equalToSystemSpacingBelow: emptyStateLabel.safeAreaLayoutGuide.bottomAnchor, multiplier: 5),
             startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
             startButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
             startButton.heightAnchor.constraint(equalToConstant: 50)
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
