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
    var onboardItem: OnboardItems? {
        didSet {
            guard let unwrappedItem = onboardItem else { return }
            setupView(item: unwrappedItem)
        }
    }
    
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var containerView = UIView()
    private var imgView = UIImageView()
    
    private func setupView(item: OnboardItems) {
        containerView = createContainerView()
        imgView = createImageView(imageName: item.imgName)
        titleLabel = configLabel(text: item.title, font: UIFont.titleFont)
        descriptionLabel = configLabel(text: item.description, font: UIFont.descriptionFont)
        containerView.addSubview(imgView)
        contentView.addSubview(containerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabelConstraints()
        descriptionLabelConstraints()
        containerViewConstraints()
        imgViewConstraints()
        
    }
    
    private func setupImgView(index: Int) {
        
    }
    
    private func createContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }
    
    private func createImageView(imageName: String) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        return imageView
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
    
    private func containerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    private func imgViewConstraints() {
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imgView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            imgView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
    }
}
