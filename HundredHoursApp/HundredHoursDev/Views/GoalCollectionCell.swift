//
//  GoalCollectionCell.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 11/2/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/*

 User enters description and taps create.
   When we go back to home view controller, in viewWillAppear, we
1) Update the textView inside the cell to resize based on content inside.
2) have to update the cell's height based on the content inside the cell.

 */

import UIKit

protocol GoalCollectionCellDelegate {
    func getCellIndex(cell: UICollectionViewCell)
}

class GoalCollectionCell: UICollectionViewCell {
    
    static let identifier = "goalCollectionID"
    var cellTextView = UITextView()
    var cellView = UIView()
    var cellLabel = UILabel()
    var optionsButton = UIButton()
    var cellHeightConstraint: NSLayoutConstraint?
    var delegate: GoalCollectionCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        cellView = createCellView()
        cellLabel = createCellLabel()
        cellTextView = createTextView()
        optionsButton = createDeleteButton()
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
        view.layer.cornerRadius = 25
        view.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 3
        return view
    }
    
    private func createCellLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
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
    
    private func createDeleteButton() -> UIButton {
        let image = UIImage(named: "optionsIcon")
        let button = UIButton()
        button.setImage(image, for: .normal)
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
            cellLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.85),
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
            optionsButton.heightAnchor.constraint(equalToConstant: 15),
            optionsButton.widthAnchor.constraint(equalToConstant: 15),
            optionsButton.rightAnchor.constraint(equalTo: cellView.safeAreaLayoutGuide.rightAnchor, constant: -15),
            optionsButton.topAnchor.constraint(equalTo: cellView.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
}
