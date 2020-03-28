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
    let viewModel = OnboardViewModel()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.onboardTitleFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.onboardDescriptionFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func setupView() {
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
    
    func configureCell(with item: OnboardItem) {
        viewModel.configureOnboardCell(item, imgView, titleLabel, descriptionLabel)
    }
        
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
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
            containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35),
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
