//
//  GoalCollectionCell.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 11/2/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GoalCollectionCell: UICollectionViewCell {
    
    static let identifier = "goalCollectionID"
    var cellTextView = UITextView()
    var cellView = UIView()
    var cellLabel = UILabel()
    var optionsButton = UIButton()
    var cellHeightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        cellView = createCellView()
        cellLabel = createCellLabel()
        cellTextView = createTextView()
        optionsButton = createOptionsButton()
        addSubview(cellView)
        addSubview(cellLabel)
        addSubview(cellTextView)
        addSubview(optionsButton)
        cellViewConstraints()
        cellLabelConstraints()
        cellTextViewConstraints()
        optionButtonConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCellView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }
    
    private func createCellLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func createTextView() -> UITextView {
        let view = UITextView()
        view.text = "Placeholder"
        view.textAlignment = .left
        view.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.font = UIFont.goalDescriptionFont
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        return view
    }
    
    private func createOptionsButton() -> UIButton {
        let image = UIImage(named: "optionsIcon")
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }
        
    func setCellLabelFont(text: String) {
        if text.count > 10 {
            cellLabel.font = UIFont.smallerTitleFont
        } else {
            cellLabel.font = UIFont.goalTitleFont
        }
    }

    private func cellViewConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            cellView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            cellView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            cellView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    private func cellLabelConstraints() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.8),
            cellLabel.heightAnchor.constraint(equalToConstant: 50),
            cellLabel.leftAnchor.constraint(equalToSystemSpacingAfter: cellView.leftAnchor, multiplier: 2),
            cellLabel.topAnchor.constraint(equalTo: cellView.topAnchor)
        ])
    }

    private func cellTextViewConstraints() {
        cellTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTextView.topAnchor.constraint(equalToSystemSpacingBelow: cellView.topAnchor, multiplier: 5),
            cellTextView.leftAnchor.constraint(equalTo: cellLabel.leftAnchor),
            cellTextView.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func optionButtonConstraints() {
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionsButton.heightAnchor.constraint(equalToConstant: 44),
            optionsButton.widthAnchor.constraint(equalToConstant: 50),
            optionsButton.rightAnchor.constraint(equalTo: cellView.safeAreaLayoutGuide.rightAnchor, constant: -5),
            optionsButton.topAnchor.constraint(equalTo: cellView.safeAreaLayoutGuide.topAnchor, constant: 5)
        ])
    }
}
