//
//  GoalTableViewCell.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 11/2/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell, UITextViewDelegate {
    
    static let identifier = "goalTableID"
    var cellTextView = UITextView()
    var cellView = UIView()
    var cellLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellView = createCellView()
        cellLabel = createCellLabel()
        cellTextView = createTextView()
        cellView.addSubview(cellLabel)
        cellView.addSubview(cellTextView)
        addSubview(cellView)
        cellViewConstraints()
        cellLabelConstraints()
        textViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        cellView.backgroundColor = selected ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cellTextView.backgroundColor = selected ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
        label.font = UIFont.goalTitleFont
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func createTextView() -> UITextView {
        let view = UITextView()
        view.text = "Placeholder"
        view.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 25
        view.font = UIFont.goalDescriptionFont
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        view.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return view
    }
    
    private func cellViewConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cellView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            cellView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func cellLabelConstraints() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.9),
            cellLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.4),
            cellLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            cellLabel.topAnchor.constraint(equalTo: cellView.topAnchor)
        ])
    }
    
    private func textViewConstraints() {
        cellTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTextView.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.6),
            cellTextView.widthAnchor.constraint(equalTo: cellView.widthAnchor),
            cellTextView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            cellTextView.topAnchor.constraint(equalTo: cellLabel.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
