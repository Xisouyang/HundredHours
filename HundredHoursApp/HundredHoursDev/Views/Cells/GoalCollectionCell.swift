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
    var cellHeightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        cellView = createCellView()
        cellLabel = createCellLabel()
        cellTextView = createTextView()
        addSubview(cellView)
        addSubview(cellLabel)
        addSubview(cellTextView)
        cellViewConstraints()
        cellLabelConstraints()
        cellTextViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCellView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    private func createCellLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func createTextView() -> UITextView {
        let view = UITextView()
        view.text = "Placeholder"
        view.textAlignment = .left
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor = .clear
        view.font = UIFont.goalDescriptionFont
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        return view
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
            cellView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
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
            cellTextView.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.7)
        ])
    }
}
